import argparse
from rich.console import Console
from rich.table import Table
import subprocess
import random
import os
from xml.dom import minidom
import json
import yaml
import csv
from utils.verifylocale import verifylocale
from utils.print_license import licenseheader
from utils.print_license import licensebody


class dataFactory:
    """Class to write out jobs ids into specific formats requested by user."""
    def __init__(self, data, user, days):
        self.data = data
        self.user = user
        self.days = days
        self.console = Console()

    def toXML(self):
        """Function to write data in XML format."""
        # Grab temp XML document and parse data
        current_doc = minidom.parse(self.data)
        current_data = current_doc.getElementsByTagName("Job_Id")

        # Create new XML document
        root = minidom.Document()
        xml = root.createElement('Job_Ids')
        root.appendChild(xml)

        # Loop through current data
        for data_entry in current_data:
            data = data_entry.childNodes[0].data
            jobChild = root.createElement("Job_Id")
            text = root.createTextNode(data)
            jobChild.appendChild(text)
            xml.appendChild(jobChild)

        # XML data is created. Write out to command line
        xml_str = root.toprettyxml(indent="\t")
        self.console.print(xml_str)

        
    def toJSON(self):
        """Function to write data in JSON format."""
        # Grab temp XML document and parse data
        current_doc = minidom.parse(self.data)
        current_data = current_doc.getElementsByTagName("Job_Id")

        # Instantiate empty dictionary and loop through XML
        dict_file = dict()
        dict_file["Job_Ids"] = list()
        for data_entry in current_data:
            data = data_entry.childNodes[0].data
            dict_file["Job_Ids"].append({"Job_Id" : data})

        # Dump JSON data to terminal window
        self.console.print(json.dumps(dict_file, indent=4))

    def toYAML(self):
        """Function to write data in YAML format."""
        # Grab temp XML document and parse data
        current_doc = minidom.parse(self.data)
        current_data = current_doc.getElementsByTagName("Job_Id")

        # Instantiate an empty list and loop through XML
        temp_list = list()
        for data_entry in current_data:
            data = data_entry.childNodes[0].data
            temp_list.append(data)

        # Create dictionary and dump YAML
        dict_file = {"Job_Ids" : temp_list}
        self.console.print(yaml.dump([dict_file]))

    def toCSV(self):
        """Function to write data in CSV format."""
        # Grab temp XML document and parse data
        current_doc = minidom.parse(self.data)
        current_data = current_doc.getElementsByTagName("Job_Id")

        # Create tempfile
        temp_csv = "/tmp/{}_get_user_jobs.csv".format(random.randint(1, 1000000))
        temp_file = open(temp_csv, "at")
        job_id_writer = csv.writer(temp_file, delimiter=",")

        # Loop through XML data and write to temp CSV file
        for data_entry in current_data:
            data = data_entry.childNodes[0].data
            job_id_writer.writerow([data])

        # Print CSV contents of temp_file
        temp_file.close()
        fin = open(temp_csv, "rt")
        self.console.print(fin.read())
        fin.close()

        # Clean up
        if os.path.exists(temp_csv):
            os.remove(temp_csv)

    def toTABLE(self):
        """Function to write data in TABLE format."""
        # Grab temp XML document and parse data
        current_doc = minidom.parse(self.data)
        current_data = current_doc.getElementsByTagName("Job_Id")

        # Create output table using rich
        table = Table(title="{}'s job ids for the past {} day(s)".format(self.user, self.days),
                        show_header=False, show_footer=False, show_edge=False)
        
        for data_entry in current_data:
            data = data_entry.childNodes[0].data
            table.add_row(data)

        # Print out table to terminal window
        self.console.print(table)


def retrieveIDS(user_id, days, output_file):
    """Function to search through job logs on torque."""
    # Retreive past couple of job log directories
    job_log_dir = "/var/spool/torque/job_logs"
    job_logs = subprocess.Popen(["ls", job_log_dir, "-t"], stdout=subprocess.PIPE)
    logs = subprocess.run(["head", "-n", days], stdin=job_logs.stdout, capture_output=True, text=True)
    job_logs.stdout.close()

    # Convert logs.stdout to a list and remove any blank lines
    logs_list = logs.stdout.split("\n")
    logs_list.remove("")

    # Loop through each job log to find job ids
    for log in logs_list:
        # Command chain to extract job ids
        command_1 = subprocess.Popen(["cat", "{}/{}".format(job_log_dir, log)], stdout=subprocess.PIPE)
        command_2 = subprocess.Popen(["grep", "-n", "<Job_Owner>{}".format(user_id)], stdin=command_1.stdout, stdout=subprocess.PIPE)
        command_3 = subprocess.run(["cut", "-d:", "-f1"], stdin=command_2.stdout, capture_output=True, text=True)
        command_1.stdout.close()
        command_2.stdout.close()

        # Convert command_3 to line_numbers list and remove any blank lines
        line_numbers = command_3.stdout.split("\n")
        line_numbers.remove("")

        # Loop through line number and retrieve XML tag
        for line_number in line_numbers:
            line_number = subprocess.run(["expr", line_number, "-", "2"], capture_output=True, text=True)
            command_4 = subprocess.Popen(["head", "-n", line_number.stdout.strip("\n"), "{}/{}".format(job_log_dir, log)], stdout=subprocess.PIPE)
            final_output = subprocess.run(["tail", "-n", "1"], stdin=command_4.stdout, capture_output=True, text=True)
            command_4.stdout.close()
            output_file.write(final_output.stdout.strip("\n").strip("\t"))


def getusersjobids(user, days, xml, json, yaml, csv, table, version, license):
    try:
        if version:
            licenseheader("getusersjobids v2.2")

        elif license:
            licensebody("getusersjobids: Retrieve users job ids for processing and analyzation.")
            return

        else:
            console = Console()
            if user is None:
                console.print("[bold red]No user id specified![/bold red]")
                console.print("Enter [bold blue]getusersjobids --help[/bold blue] for help.")
                return

            # Create temporary file to write initial XML
            temp = "/tmp/{}_get_user_jobs.xml".format(random.randint(1, 1000000))
            fout = open(temp, "at")
            fout.write("<Job_Ids>")
            retrieveIDS(user, str(days), fout)
            fout.write("</Job_Ids>")
            fout.close()

            # Instantiate dataFactory class to print out data
            data_factory = dataFactory(temp, user, days)

            # Determine which data format to write out to terminal
            if xml:
                data_factory.toXML()
                if os.path.exists(temp):
                    # Delete temp XML file
                    os.remove(temp)
                return

            elif json:
                data_factory.toJSON()
                if os.path.exists(temp):
                    # Delete temp XML file
                    os.remove(temp)
                return

            elif yaml:
                data_factory.toYAML()
                if os.path.exists(temp):
                    # Delete temp XML file
                    os.remove(temp)
                return

            elif csv:
                data_factory.toCSV()
                if os.path.exists(temp):
                    # Delete temp XML file
                    os.remove(temp)
                return

            elif table:
                data_factory.toTABLE()
                if os.path.exists(temp):
                    # Delete temp XML file
                    os.remove(temp)
                return

            else:
                data_factory.toTABLE()
                if os.path.exists(temp):
                    # Delete temp XML file
                    os.remove(temp)
                return
    
    except RuntimeError:
        return


if __name__ == "__main__":
    # Set locale to UTF-8 before continuing
    out, err = verifylocale()
    if err != None:
        console = Console()
        console.print("Uh oh. Looks like the UTF-8 locale is not supported on your system.", 
                      "Please try using [bold blue]locale-gen en_US.UTF-8[/bold blue] before continuing.")

    else:
        parser = argparse.ArgumentParser()
        parser.add_argument("-u", "--user", default=None, help="User to query (example: jcn23).")
        parser.add_argument("-d", "--days", type=int, default=5, help="Specify the number of days to check in the torque job logs (default: 5).")
        parser.add_argument("--xml", action="store_true", help="Print job ids in XML format.")
        parser.add_argument("--json", action="store_true", help="Print job ids in JSON format.")
        parser.add_argument("--yaml", action="store_true", help="Print job ids in YAML format.")
        parser.add_argument("--csv", action="store_true", help="Print job ids in CSV format.")
        parser.add_argument("--table", action="store_true", help="Print job ids in tabular format.")
        parser.add_argument("-V", "--version", action="store_true", help="Print version info.")
        parser.add_argument("--license", action="store_true", help="Print licensing info.")
        args = parser.parse_args()
        getusersjobids(args.user, args.days, args.xml, args.json, args.yaml, args.csv, args.table, args.version, args.license)

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
import lxml
from bs4 import BeautifulSoup
import xml.etree.ElementTree as et
from utils.verifylocale import verifylocale
from utils.print_license import licenseheader
from utils.print_license import licensebody


class dataFactory:
    def __init__(self, data, jobid):
        self.data = data
        self.jobid = jobid
        self.console = Console()

    def toXML(self):
        """Function to write data in XML format."""
        # Short and sweet. Just read file
        fin = open(self.data, "rt")
        xml_data = fin.read()
        fin.close()
        soup = BeautifulSoup(xml_data, features="xml")

        # Reform XML
        for job_script in soup.find_all("job_script"):
            tmp = job_script.text
            tmp1 = tmp.replace('&#38;', "&")
            tmp2 = tmp1.replace('&lt;', "<")
            tmp3 = tmp2.replace('&gt;', ">")
            tmp4 = tmp3.replace('&#39;', "'")
            tmp5 = tmp4.replace('&#34;', '"')
            job_script.string = tmp5

        self.console.print(soup.prettify())

    def toJSON(self):
        """Function to write data in JSON format."""
        # Pull tags and text from XML document
        content_list = self.__parseData()

        # Create dictionary and dump to JSON
        temp_dict = dict()
        temp_dict["Jobinfo"] = list()
        for item in content_list:
            if item[0] == "job_script":
                temp_dict["Jobinfo"].append({item[0]:self.__reformXML(item[1])})
            
            else:
                temp_dict["Jobinfo"].append({item[0]:item[1]})

        self.console.print(json.dumps(temp_dict, indent=4))

    def toYAML(self):
        """Function to write data in YAML format."""
        # Pull tags and text from XML document
        content_list = self.__parseData()

        # Create dictionary and dump to YAML
        temp_dict = dict()
        for item in content_list:
            if item[0] == "job_script":
                temp_dict.update({item[0]:self.__reformXML(item[1])})
            
            else:
                temp_dict.update({item[0]:item[1]})

        self.console.print(yaml.dump([temp_dict]))

    def toTABLE(self):
        """Function to write data in tabular format."""
        # Pull tags and text from XML document
        content_list = self.__parseData()

        # Once document has been read through create table
        table = Table(title="Info for job {}".format(self.jobid), show_lines=True)

        # Add columns
        table.add_column("Tag Name:", justify="left")
        table.add_column("Content:", justify="left")

        # Add rows
        for item in content_list:
            if item[0] == "job_script":
                table.add_row(item[0], self.__reformXML(item[1]))
            
            else:
                table.add_row(item[0], item[1])

        # Print out final table to terminal window
        self.console.print(table)

    def __parseData(self):
        """Simple function to retrieve all the XML tag names and text."""
        tree = et.ElementTree(file=self.data)
        root = tree.getroot()
        content_list = list()

        # Read through document and items to content list
        for child in root:
            if child.text != "\n":
                content_list.append((child.tag, child.text))
            for grandchild in child:
                if grandchild.text != "\n":
                    content_list.append((grandchild.tag, grandchild.text))

        return content_list

    def __reformXML(self, job_script):
        """Simple function to turn certain XML characters back into human-readable form."""
        tmp = job_script
        tmp1 = tmp.replace('&#38;', "&")
        tmp2 = tmp1.replace('&lt;', "<")
        tmp3 = tmp2.replace('&gt;', ">")
        tmp4 = tmp3.replace('&#39;', "'")
        tmp5 = tmp4.replace('&#34;', '"')
        
        # Return reformatted string
        return tmp5


def subprocessCMD(command):
    """Function to make chaining commands together much easier."""
    process = subprocess.run(command, capture_output=True, text=True, shell=True)
    return process.stdout.strip("\n")


def XMLRepair(xml_input):
    """Function to fix job script notation in original XML output"""
    # Use beautiful soup to parse malformed XML tag
    soup = BeautifulSoup(xml_input, features="xml")

    # Loop through job_script tags
    for jobscript in soup.find_all("job_script"):
        tmp = jobscript.text
        tmp1 = tmp.replace("&", '&#38;')
        tmp2 = tmp1.replace("<", '&lt;')
        tmp3 = tmp2.replace(">", '&gt;')
        tmp4 = tmp3.replace("'", '&#39;')
        tmp5 = tmp4.replace('"', '&#34;')
        jobscript.string = tmp5

    # Return corrected XML
    return str(soup)


def findJobID(job_id, job_log_dir, log_dir):
    """Function to test if job id exists in the job_log directory on torque."""
    # Execute test command
    command_exec = subprocessCMD("cat {}/{} | grep {}".format(job_log_dir, log_dir, job_id))
    if command_exec != "":
        return True

    else:
        return False


def retrieveJobInfo(job_id, days, output_file):
    """Retrieve the XML job info stored in the job_log directory on torque."""
     # Retreive past couple of job log directories
    job_log_dir = "/var/spool/torque/job_logs"
    logs = subprocessCMD("ls {} -t | head -n {}".format(job_log_dir, days))

    # Convert logs.stdout to a list and remove any blank lines
    logs_list = logs.split("\n")
    
    try:
        logs_list.remove("")

    except ValueError:
        pass

    # Loop through job log to find job info
    found_job_id = False
    for log in logs_list:
        if findJobID(job_id, job_log_dir, log):
            # Get line 1 using commands in the shell
            line_1 = subprocessCMD("cat {}/{} | grep -n {} | head -n 1 | cut -d: -f1".format(job_log_dir, log, job_id))

            # Get line 0 using commands in the shell
            line_0 = subprocessCMD("head -n {} {}/{} | grep -n \"<Jobinfo>\" | tail -n1 | cut -d: -f1".format(line_1, job_log_dir, log))

            # Get line 3 using commands in the shell
            line_3 = subprocessCMD("tail -n +{} {}/{} | grep -n \"</Jobinfo>\" | head -n 1 | cut -d: -f1".format(line_0, job_log_dir, log))

            # Reevaluate line 3
            line_3 = subprocessCMD("expr {} + {}".format(line_3, line_0))

            # Get final output and write to temp file
            almost_final_output = subprocessCMD("sed -n {},{}p {}/{}".format(line_0, line_3, job_log_dir, log))
            final_output = XMLRepair(almost_final_output)
            output_file.write(final_output)
            found_job_id = True
            break

    if found_job_id is False:
        console = Console()
        console.print("[bold red]{} not found.[/bold red]".format(job_id))


def getjobinfo(jobid, file, days, xml, json, yaml, table, version, license):
    try:
        if version:
            licenseheader("getjobinfo v2.2")
            return

        elif license:
            licensebody("getjobinfo: Query job ids to collect corresponding job info.")
            return

        else:
            console = Console()
            
            # Read job ids from a file
            if file is not None:
                current_doc = minidom.parse(file)
                current_data = current_doc.getElementsByTagName("Job_Id")

                # Loop through each XML tag within the file
                for data_entry in current_data:
                    data = data_entry.childNodes[0].data
                    job_id = data.split(".")

                    # Get job info
                    temp = "/tmp/{}_get_job_info.xml".format(job_id[0])
                    fout = open(temp, "at")
                    retrieveJobInfo(str(job_id[0]), str(days), fout)
                    fout.close()

                    # Print job info out to terminal window
                    datafactory = dataFactory(temp, job_id[0])

                    if xml:
                        datafactory.toXML()
                        if os.path.exists(temp):
                            # Delete temp XML file
                            os.remove(temp)
                        print("\n")

                    elif json:
                        datafactory.toJSON()
                        if os.path.exists(temp):
                            # Delete temp XML file
                            os.remove(temp)
                        print("\n")

                    elif yaml:
                        datafactory.toYAML()
                        if os.path.exists(temp):
                            # Delete temp XML file
                            os.remove(temp)
                        print("\n")

                    elif table:
                        datafactory.toTABLE()
                        if os.path.exists(temp):
                            # Delete temp XML file
                            os.remove(temp)
                        print("\n")

                    else:
                        datafactory.toXML()
                        if os.path.exists(temp):
                            # Delete temp XML file
                            os.remove(temp)
                        print("\n")

                return

            # Check if user specified any job ids
            elif len(jobid) == 0:
                console.print("[bold red]No job ids specified![/bold red]")
                console.print("Enter [bold blue]getjobinfo --help[/bold blue] for help.")
                return
            
            elif len(jobid) == 1:
                temp = "/tmp/{}_get_job_info.xml".format(random.randint(1, 1000000))
                fout = open(temp, "at")
                retrieveJobInfo(str(jobid[0]), str(days), fout)
                fout.close()

                # Create dataFactory to process data
                datafactory = dataFactory(temp, jobid[0])

                # Call function in data factory according to what is specified by the user
                if xml:
                    datafactory.toXML()
                    if os.path.exists(temp):
                        # Delete temp XML file
                        os.remove(temp)
                    return

                elif json:
                    datafactory.toJSON()
                    if os.path.exists(temp):
                        # Delete temp XML file
                        os.remove(temp)
                    return

                elif yaml:
                    datafactory.toYAML()
                    if os.path.exists(temp):
                        # Delete temp XML file
                        os.remove(temp)
                    return

                elif table:
                    datafactory.toTABLE()
                    if os.path.exists(temp):
                        # Delete temp XML file
                        os.remove(temp)
                    return

                else:
                    datafactory.toXML()
                    if os.path.exists(temp):
                        # Delete temp XML file
                        os.remove(temp)
                    return

            else:
                # Loop through jobs specified by the user
                tmp_xml_files = list()
                for job in jobid:
                    tmp_xml_files.append("/tmp/{}_get_job_info.xml".format(job))

                # Get info on all the jobs
                i = 0
                for job in jobid:
                    fout = open(tmp_xml_files[i], "at")
                    retrieveJobInfo(str(job), str(days), fout)
                    fout.close()
                    i += 1
                
                i = 0
                for xml_file in tmp_xml_files:
                    datafactory = dataFactory(xml_file, jobid[i])
                    i += 1

                    # Print out the data in the format specified by the user
                    if xml:
                        datafactory.toXML()
                        if os.path.exists(xml_file):
                            # Delete temp XML file
                            os.remove(xml_file)
                        print("\n")

                    elif json:
                        datafactory.toJSON()
                        if os.path.exists(xml_file):
                            # Delete temp XML file
                            os.remove(xml_file)
                        print("\n")

                    elif yaml:
                        datafactory.toYAML()
                        if os.path.exists(xml_file):
                            # Delete temp XML file
                            os.remove(xml_file)
                        print("\n")

                    elif table:
                        datafactory.toTABLE()
                        if os.path.exists(xml_file):
                            # Delete temp XML file
                            os.remove(xml_file)
                        print("\n")

                    else:
                        datafactory.toXML()
                        if os.path.exists(xml_file):
                            # Delete temp XML file
                            os.remove(xml_file)
                        print("\n")

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
        parser.add_argument("jobid", nargs="*")
        parser.add_argument("-f", "--file", default=None, help="Read job ids to query from an XML file instead.")
        parser.add_argument("-d", "--days", type=int, default=5, help="Specify the number of days to check in the torque job logs (default: 5).")
        parser.add_argument("--xml", action="store_true", help="Print job info in XML format.")
        parser.add_argument("--json", action="store_true", help="Print job info in JSON format.")
        parser.add_argument("--yaml", action="store_true", help="Print job info in YAML format.")
        parser.add_argument("--table", action="store_true", help="Print job info in tabular format.")
        parser.add_argument("-V", "--version", action="store_true", help="Print version info.")
        parser.add_argument("--license", action="store_true", help="Print licensing info.")
        args = parser.parse_args()
        getjobinfo(args.jobid, args.file, args.days, args.xml, args.json, args.yaml, args.table, args.version, args.license)

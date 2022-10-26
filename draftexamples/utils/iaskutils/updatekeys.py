import os
import shutil
import subprocess
import argparse
from utils.special_print import print_good
from utils.special_print import print_bad
from utils.special_print import print_info
from utils.special_print import important_info
from utils.special_print import printrichtext
from utils.print_license import licenseheader
from utils.print_license import licensebody
from utils.verifylocale import verifylocale


def mainblock(home_dir):
    """Block of code where main operations occur."""
    current_date = subprocess.getoutput('date +"%d%b%Y-%T"')
    important_info("Checking if files exist...\n")

    # Check if .ssh directory even exists
    if os.path.isdir("{}/.ssh".format(home_dir)) is False:
        print_info("~/.ssh does not exist! Now creating ~/.ssh.\n")
        os.mkdir("{}/.ssh".format(home_dir))

    # Check if config file exists
    config_file = "{}/.ssh/config".format(home_dir)
    if os.path.exists(config_file):
        print_good("~/.ssh/config exists. Moving the existing version to ~/.ssh/config.replaced.{}. You can copy this back to revert to convert to the current configuration.\n".format(current_date))
        shutil.move(config_file, config_file + ".replace.{}".format(current_date))

    else:
        print_info("~/.ssh/config does not exist. It will be created in this process.\n")
        
    # Check if authorized_keys file exists
    authorized_keys_file = "{}/.ssh/authorized_keys".format(home_dir)
    if os.path.exists(authorized_keys_file):
        print_good("~/.ssh/authorized_keys exists. Moving the existing version to ~/.ssh/authorized_keys.replaced.{}. You can copy this back to revert to convert to the current configuration.\n".format(current_date))
        shutil.move(authorized_keys_file, authorized_keys_file + ".replace.{}".format(current_date))

    else:
        print_info("~/.ssh/authorized_keys does not exist. It will be created in this process.\n")

    # Check if id_rsa file exists
    id_rsa_file = "{}/.ssh/id_rsa".format(home_dir)
    if os.path.exists(id_rsa_file):
        print_good("~/.ssh/id_rsa exists. Moving the existing version to ~/.ssh/id_rsa.replaced.{}. You can copy this back to revert to convert to the current configuration.\n".format(current_date))
        shutil.move(id_rsa_file, id_rsa_file + ".replace.{}".format(current_date))

    else:
        print_info("~/.ssh/id_rsa does not exist. It will be created in this process.\n")

    # Check if id_rsa.pub file exists
    id_rsa_pub_file = "{}/.ssh/id_rsa.pub".format(home_dir)
    if os.path.exists(id_rsa_pub_file):
        print_good("~/.ssh/id_rsa.pub exists. Moving the existing version to ~/.ssh/id_rsa.pub.replaced.{}. You can copy this back to revert to convert to the current configuration.\n".format(current_date))
        shutil.move(id_rsa_pub_file, id_rsa_pub_file + ".replace.{}".format(current_date))

    else:
        print_info("~/.ssh/id_rsa.pub does not exist. It will be created in this process.\n")

    # Create new ssh key
    important_info("Creating your key...")
    subprocess.run(["ssh-keygen -N '' -f {}/.ssh/id_rsa > {}/.ssh/{}.keyFingerprintAndRandomart".format(home_dir, home_dir, current_date)], shell=True)
    shutil.copy("{}/.ssh/id_rsa".format(home_dir), "{}/.ssh/id_rsa.{}".format(home_dir, current_date))
    shutil.copy("{}/.ssh/id_rsa.pub".format(home_dir), "{}/.ssh/id_rsa.pub.{}".format(home_dir, current_date))
    print_good("Your key fingerprint and randomart image were saved in ~/.ssh/{}.keyFingerprintAndRandomart".format(current_date))

    # Authorize for this location (home is shared on the compute nodes)
    print_info("Setting up for use on the compute nodes...")
    shutil.copy("{}/.ssh/id_rsa.pub".format(home_dir), "{}/.ssh/authorized_keys".format(home_dir))

    # Ensure that this is can be used
    print_info("Setting up the host key checking...")
    subprocess.run(["echo 'StrictHostKeyChecking no' > {}/.ssh/config".format(home_dir)], shell=True)

    # Correct permissions
    print_info("Updating the file permissions...")
    os.chmod("{}/.ssh/config".format(home_dir), 0o444)
    os.chmod("{}/.ssh".format(home_dir), 0o700)

    printrichtext("[bold bright_green]All done![/bold bright_green]")


def updatekeys(prompt, version, license):
    """updatekeys: Create a new ssh-key that will allow you to log onto the compute nodes without entering a password."""
    if version:
        licenseheader("updatekeys v2.0")

    elif license:
        licensebody("updatekeys: Create a new ssh-key that will allow you to log onto the compute nodes without entering a password.")

    else:
        home_env_var = os.getenv("HOME")
        os.chdir(home_env_var)

        # Start execution
        current_date = subprocess.getoutput('date +"%d%b%Y-%T"')
        important_info("This script will create a new ssh-key that will allow you to log onto the compute nodes without entering a password. The script is set-up to copy any existing files so that previous configuretions are not lost. These files will include {} in the name and will be listed to the screen.\n".format(current_date))
        important_info("The key will be created without a passphrase. You can exit this script and create your ssh key manually if you wish to use a passphrase. Note that you will be prompted for this passphrase every time you or your script attempts to use an additional node, similar to requiring a password.\n")

        if prompt:
            mainblock(home_env_var)

        else:
            # Ask user for yes or no
            user_input = input("Are you sure you want to continue? <y/N> ").lower()
            if user_input == "y" or user_input == "yes":
                mainblock(home_env_var)
                return

            else:
                print_info("Exiting...")
                return


if __name__ == "__main__":
    out, err = verifylocale()
    if err != None:
        printrichtext("Uh oh. Looks like the UTF-8 locale is not supported on your system! " +
                      "Please try using [bold blue]locale-gen en_US.UTF-8[/bold blue] before continuing.")

    else:
        parser = argparse.ArgumentParser(description="updatekeys - create a new ssh-key that will allow you to log onto the compute nodes without entering a password.")
        parser.add_argument("-y", "--yes", action="store_true", help="Say yes to all interactive prompts,")
        parser.add_argument("-V", "--version", action="store_true", help="Print version info.")
        parser.add_argument("--license", action="store_true", help="Print licensing info.")
        args = parser.parse_args()
        updatekeys(args.yes, args.version, args.license)

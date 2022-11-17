import os
import shutil
import argparse
from utils.special_print import print_good
from utils.special_print import print_bad
from utils.special_print import print_info
from utils.special_print import important_info
from utils.special_print import printrichtext
from utils.print_license import licenseheader
from utils.print_license import licensebody
from utils.verifylocale import verifylocale


def setupcondasymlink(version, license):
    """setupcondasymlink: A simple script to relocate the conda cache to the work directory."""
    if version:
        licenseheader("setupcondasymlink v1.2.1")

    elif license:
        licensebody("setupcondasymlink: A simple script to relocate the conda cache to the work directory.")

    else:
        home_env_var = os.getenv('HOME')
        os.chdir(home_env_var)
        conda_cache_path = "{}/.conda".format(home_env_var)
        conda_cache_symlink_path = "{}/work/.conda".format(home_env_var)
        
        # Verify that .conda exists
        if os.path.isdir(conda_cache_path) and os.path.islink(conda_cache_path) is False:
            # Move conda cache to work and create symlink
            shutil.move(conda_cache_path, conda_cache_symlink_path)
            os.symlink(conda_cache_symlink_path, conda_cache_path)
            print_good("The conda cache symlink has been established!")

        elif os.path.islink(conda_cache_path):
            print_info("The conda cache symlink already exists.")

        else:
            print_bad("The conda cache does not exist in {}!".format(home_env_var))
            important_info("Please initialize the conda cache by creating an environment using conda.")

        return


if __name__ == "__main__":
    out, err = verifylocale()
    if err != None:
        printrichtext("Uh oh. Looks like the UTF-8 locale is not supported on your system! " +
                      "Please try using [bold blue]locale-gen en_US.UTF-8[/bold blue] before continuing.")
    
    else:
        parser = argparse.ArgumentParser(description="setupcondasymlink - a simple script to relocate the conda cache to the work directory.")
        parser.add_argument("-V", "--version", action="store_true", help="Print version info.")
        parser.add_argument("--license", action="store_true", help="Print licensing info.")
        args = parser.parse_args()
        setupcondasymlink(args.version, args.license)

import os
import shutil
import argparse
from utils.special_print import print_good
from utils.special_print import print_bad
from utils.special_print import print_info
from utils.special_print import important_info
from utils.special_print import printrichtext
from utils.compression import Compression
from utils.print_license import licenseheader
from utils.print_license import licensebody
from utils.verifylocale import verifylocale


def relinkworkscratch(version, license):
    """relinkworkscratch: A simple script to reestablish the work and scratch directory symlinks in a user's home directory."""
    if version:
        licenseheader("relinkworkscratch v1.2.1")

    elif license:
        licensebody("relinkworkscratch: A simple script to reestablish the work and scratch directory symlinks in a user's home directory.")

    else:
        # Grab important info for system
        home_env_var = os.getenv('HOME')
        user_name = os.getenv('USER')
        work_dir = "/storage/work/{}".format(user_name)
        scratch_dir = "/gpfs/scratch/{}".format(user_name)

        # Verify that user work and scratch directories exist
        if os.path.isdir(work_dir) is False:
            print_bad("Hm. It looks like {} does not exist. Please contact the i-ASK center for help.".format(work_dir))
            return

        if os.path.isdir(scratch_dir) is False:
            print_bad("Hm. It looks like {} does not exist. Please contact the i-ASK center for help.".format(scratch_dir))
            return

        # If checks are good, continue
        try:
            os.chdir(home_env_var)

        except OSError:
            print_bad("Could not change into home directory. Please contact the i-ASK center for help.")
            return

        # Fix work symlink
        work_symlink_path = "{}/work".format(home_env_var)
        if os.path.isdir(work_symlink_path) and os.path.islink(work_symlink_path) is False:
            # Compress fake work to tar.gz archive and then delete old directory
            compressor = Compression("work", "old-work", home_env_var)
            compressor.togzip()
            shutil.rmtree("work")

            # Create new symlink
            os.symlink(work_dir, work_symlink_path)
            print_good("Work symlink has been fixed!")

        elif os.path.islink(work_symlink_path) is False:
            os.symlink(work_dir, work_symlink_path)
            print_good("Work symlink has been fixed!")

        else:
            print_info("No action needed for work directory.")

        # Fix scratch symlink
        scratch_symlink_path = "{}/scratch".format(home_env_var)
        if os.path.isdir(scratch_symlink_path) and os.path.islink(scratch_symlink_path) is False:
            # Compress fake scratch to tar.gz archive and then delete old directory
            compressor = Compression("scratch", "old-scratch", home_env_var)
            compressor.togzip()
            shutil.rmtree("scratch")

            # Create new symlink
            os.symlink(work_dir, scratch_symlink_path)
            print_good("Scratch symlink has been fixed!")

        elif os.path.islink(scratch_symlink_path) is False:
            os.symlink(work_dir, scratch_symlink_path)
            print_good("Scratch symlink has been fixed!")

        else:
            print_info("No action needed for scratch directory.")

        print_good("All done!")


if __name__ == "__main__":
    out, err = verifylocale()
    if err != None:
        printrichtext("Uh oh. Looks like the UTF-8 locale is not supported on your system! " +
                      "Please try using [bold blue]locale-gen en_US.UTF-8[/bold blue] before continuing.")
    
    else:
        parser = argparse.ArgumentParser(description="relinkworkscratch - a simple script to reestablish the work and scratch directory symlinks in a user's home directory.")
        parser.add_argument("-V", "--version", action="store_true", help="Print version info.")
        parser.add_argument("--license", action="store_true", help="Print licensing info.")
        args = parser.parse_args()
        relinkworkscratch(args.version, args.license)

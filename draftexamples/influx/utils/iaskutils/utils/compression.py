import tarfile
from zipfile import ZipFile
from progress.bar import Bar
import os
from .special_print import important_info


class Compression:
    """A simple class that converts files into multiple data types."""
    def __init__(self, directory, user_info, output_directory):
        self.directory = directory
        self.user_info = user_info
        self.output_directory = output_directory

    def tozip(self):
        """Compress files into a zip archive."""
        file_paths = self.__getallfilepaths()
        with ZipFile("{}.zip".format(self.user_info), "w") as zipfile:
            bar = Bar("Compressing files into zip archive", max=len(file_paths))
            for file in file_paths:
                zipfile.write(file)
                bar.next()

            bar.finish()

    def togzip(self):
        """Compress files into a tar.gz archive."""
        file_paths = self.__getallfilepaths()
        with tarfile.open("{}.tar.gz".format(self.user_info), "w:gz") as tarball:
            bar = Bar("Compressing files into tar.gz archive", max=len(file_paths))
            for file in file_paths:
                tarball.add(file)
                bar.next()

            bar.finish()

    def tobzip(self):
        """Compress files into a tar.bz2 archive."""
        file_paths = self.__getallfilepaths()
        with tarfile.open("{}.tar.bz2".format(self.user_info), "w:bz2") as tarball:
            bar = Bar("Compressing files into tar.bz2 archive", max=len(file_paths))
            for file in file_paths:
                tarball.add(file)
                bar.next()

            bar.finish()

    def toxz(self):
        """Compress files into a tar.xz archive."""
        file_paths = self.__getallfilepaths()
        with tarfile.open("{}.tar.xz".format(self.user_info), "w:xz") as tarball:
            bar = Bar("Compressing files into tar.xz archive", max=len(file_paths))
            for file in file_paths:
                tarball.add(file)
                bar.next()

            bar.finish()

    def totar(self):
        """Compress files into a regular tar archive."""
        file_paths = self.__getallfilepaths()
        with tarfile.open("{}.tar".format(self.user_info), "w") as tarball:
            bar = Bar("Compressing files into tar archive", max=len(file_paths))
            for file in file_paths:
                tarball.add(file)
                bar.next()

            bar.finish()

    def __getallfilepaths(self):
        """Retrieve the paths to all the files located in a specific directory."""
        file_paths = []

        for root, directories, files in os.walk(self.directory):
            for filename in files:
                filepath = os.path.join(root, filename)
                file_paths.append(filepath)

        return file_paths

    @property
    def complete(self):
        """Simple property to tell user how they can download created archives."""
        important_info("\nPlease go to Files > Home Directory from \n"
                        "https://portal.aci.ics.psu.edu/, download the created \n"
                        "archive located in {}, and mail the archive \n"
                        "to iask@ics.psu.edu".format(self.output_directory))


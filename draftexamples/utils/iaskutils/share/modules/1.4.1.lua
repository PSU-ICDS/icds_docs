help([[iaskutils is a collection of various python scripts and tools used 
by the Penn State ICDS i-ASK helpdesk to help the users of the Roar supercomputer.

The iaskutils collection currently consists of the following scripts:

- collector: A simple script to collect information about your environment.

- gathero: A script to collect essential information about a user's job(s).

- relinkworkscratch: A simple script to reestablish the work and scratch directory symlinks in a user's home directory.

- setupcomsolsymlink:  A simple script to relocate the COMSOL cache to the work directory.

- setupcondasymlink: A simple script to relocate the conda cache to the work directory.

- updatekeys: Create a new ssh-key that will allow you to log onto the compute nodes without entering a password.

For help using these commands, simply refer to the man pages or please contact the i-ASK center
at iask@ics.psu.edu for assistance.]])

whatis("Description: iaskutils is a collection of various python scripts and tools used by the Penn State ICDS i-ASK helpdesk to help the users of the Roar supercomputer.")
whatis("collector version: 1.2.1")
whatis("gathero version: 1.2.1")
whatis("relinkworkscratch version: 1.2.1")
whatis("setupcomsolsymlink version: 1.2.1")
whatis("setupcondasymlink version: 1.2.1")
whatis("updatekeys version: 2.0")
whatis("GitHub repository: https://github.com/ICDS-Roar/iaskutils")
whatis("Author: Jason C. Nucciarone (jason.nucciarone@gmail.com, jcn23@psu.edu")

-- Add Python related files
prepend_path("PATH", "/gpfs/group/dml129/default/sw7/python-3.9.4/bin")
prepend_path("LIBRARY_PATH", "/gpfs/group/dml129/default/sw7/python-3.9.4/lib")
prepend_path("LD_LIBRARY_PATH", "/gpfs/group/dml129/default/sw7/python-3.9.4/lib")
prepend_path("INCLUDE", "/gpfs/group/dml129/default/sw7/python-3.9.4/include")
prepend_path("C_INCLUDE_PATH", "/gpfs/group/dml129/default/sw7/python-3.9.4/include")
prepend_path("CPLUS_INCLUDE_PATH", "/gpfs/group/dml129/default/sw7/python-3.9.4/include")
prepend_path("MANPATH", "/gpfs/group/dml129/default/sw7/python-3.9.4/share/man")
prepend_path("PKG_CONFIG_PATH", "/gpfs/group/dml129/default/sw7/python-3.9.4/lib/pkgconfig")
prepend_path("CMAKE_PREFIX_PATH", "/gpfs/group/dml129/default/sw7/python-3.9.4")

-- Add iaskutils specifc paths
prepend_path("PATH", "/gpfs/group/dml129/default/sw7/iaskutils/bin")
prepend_path("MANPATH", "/gpfs/group/dml129/default/sw7/iaskutils/share/man")

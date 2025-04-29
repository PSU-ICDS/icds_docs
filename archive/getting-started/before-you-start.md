# Before you start

## Best Practices

!!! warning "Don't use submit nodes for heavy computing."
     Submit nodes are for preparing files, submitting jobs, 
     examining results, and transferring files.

!!! warning "Don't store files on scratch."
     [Scratch is not backed up](../handling-data/file-storage.md/#quotas), 
     and files more than 30 days old are deleted.

!!! warning "Don't overrun your file storage quota."
     If you fill your allotted disk space, weird errors result.
     Keep an eye on your [disk space usage](../handling-data/file-storage.md/#quotas).

!!! warning "Don't waste your compute resources."
     Start with interactive sessions to test your workflow and set up your software.
     When starting batch processing, run smaller test jobs to make sure your code works.


## Roar uses Linux

The operating system for Roar is Red Hat Enterprise Linux 8 ([RHEL8](https://docs.redhat.com/en/documentation/red_hat_enterprice_linux/8),
a text-based operating system where users interact with the system
by typing commands, called a command line interface (CLI). Many prefer the CLI
interface because it is fast and responsive and many tasks can be automated with scripts.

To take full advantage of the functionality of Roar, it is recommended that one be
familiar with navigating in the Linux CLI and capable of performing the following tasks:

 - Navigating the file system using commands such as `cd` and `ls`
 - Viewing and editing text files using commands such as `cat` and `nano`
 - Searching for files and their content using `grep` and `find`

To learn more about any of the above, we recommend following the [HPC Carpentry lesson "Introduction
to Using the Shell in a HPC Context"](https://www.hpc-carpentry.org/hpc-shell/). The lesson contents
can be followed once [a terminal session has been establshed](connecting-to-rc.md/#connecting-via-ssh).

---
title: Basics of the Roar Resources
---

  

#### 5.1 System Usage

The Roar system uses the Red Hat 7.9 Linux operating system with the module system set up for software. All users will have to use the terminal to access programs, including Open OnDemand users of ACI-i.

##### <span class="titlemark">5.1.1</span> Shells

Unix/Linux shells are command line interpreters that allow for a user to interact with their operating system through utility commands and programs. The Default Unix/Linux shell is BASH (the Bourne-Again SHell) which has extensive online documentation, and common or necessary commands are shown in the table below.

|Command|Description (For full documentation, use the command 'man command' to bring up the manual or find online documentation)|
|--- |--- |
|ls|The 'list' (ls) command is used to display all the files in your current directory. Using the '-a' flag will also show any hidden files (typically files beginning with a '.' like .bashrc)|
|cd|This is the 'change directory' command. Use this to traverse directories (like 'cd work'). To move back a directory level, use 'cd..'.|
|mv|The 'move' command takes two arguments, the first being the file to move and the second being the directory said file should be moved to ('mv file.txt /work/newdirectory/'). Note: 'mv' can also be used to rename a file if the second argument is simply a new file name instead of a directory.|
|mkdir|This command is used to make directories.|
|rmdir|This command is used to delete directories ('rm -rf directory' would also work).|
|touch|This command is used to create files in a similar way to mkdir. ('touch test.txt' will create an empty text file named test).|
|rm|This is the 'remove' command. As mentioned above, it can be used recursively to delete entire directory trees, or it can be used with no flags and a file as the argument to delete a single file.|
|locate|This command is used to locate files on a system. The flag '-i' will make the query case-  
insensitive, and asterisks ('*') will indicate wildcard characters.|
|clear|Clears the terminal of all previous outputs leaving you with a clean prompt.|
|history|Shows the previous commands entered.|
|find|Used for finding files, typically with the -name flag and the name of the file.|
|grep|Used for searching within files.|
|awk|A programming language typically used for data extraction.|
|id|Show all of the groups a user is in.|
|du|Show the disk usage. Typically used with -h (for human readable) and -max-depth=1 to limit to only the directories in that level rather than all files.|
|env|Print out all of the current environment variables.|
|less|View a file.|
|cp|Copy a file. Note the -r (recursive) flag can be used to copy directories.|
|alias|Create an alias (something short) that is interpreted as something else (a complicated command).|
|pwd|Print the current working directory.|
|chmod|Change file permissions.|
|chgrp|Change group for a file or directory.|
|ldd|Show the shared libraries required for an executable or library.|
|top|See the node usage. Often used with command U .|
|/usr/bin/time|Show time and memory statistics for a command being run. Often used with the -v (verbose) flag.|
|bg|Continue running a paused task in the background|
|fg|Bring a background task into the foreground|
|Ctrl + c|Kill a process.|
|Ctrl + z|Suspend a process|
|Ctrl + r|Search through your history for a command that includes the text typed next.|
|* * *|* * *|



There are also some special characters to be aware of that will be helpful.

*   `~` is your home directory
*   `.` means here
*   `..` means up one directory
*   `*` is the wildcard: `*` for all files or `*.png` for all png files
*   `|`is pipe (send the output to another command)
*   `>` means write command output to a file (Example: `ls > log.ls`)

Most commands have a manual that show all of the different ways the command can be used. For example,

`man ls`

shows all of the info for the `ls` command. You can use the arrows to scroll through the manual and the letter `q` for quit. Some commands will also provide a shortened version of the manual showing the available flags if an incorrect flag is used. For example,

`mam-list-funds -banana`

brings up a list of all of the flags available for `mam-list-funds`. Any non-working flag will allow for this. Note that this doesn’t give information about what the flags do, just what the flags are. This may be enough to remind you of something you had done previously.  

All shells utilize configuration files. For BASH, this is split between 2 files: `~/.bash_profile` and `~/.bashrc`.  
(NOTE: `~/` in Linux is a way to specify your own home directory!). The `.bash_profile` file is always parsed when a terminal is open, including with an SSH session. To connect the two in such a way that `.bashrc` will always be sourced for a session, make sure this code is included in your `~/.bash_profile`:

`if [ -f ~/.bashrc ]; then . ~/.bashrc fi`

##### <span class="titlemark">5.1.2</span> Alternative Shells

BASH is only the default shell, and it doesn’t come with quite a few features that many Linux power-users would like to have on the command-line. Other common shells include KSH (KornSHell), ZSH (Z SHell), and FISH (Friendly-Interface SHell). These shells all have documentation available online regarding their installation and customization.  

##### <span class="titlemark">5.1.3</span> Environmental Variables

Environment variables are values that pertain to certain aspects of an operating system’s configurations. These variables are typically used by utilities and programs for things like finding out where the user’s home directory is (`$HOME`) or where to look for executable files (`$PATH`). The prompt for BASH is held as the variable `PS1`.  

You can print the environment variable to the screen using the `echo` command:

`echo $HOME`

A good way to view environment variables that are set is by using the `env` command

`env`

which outputs all of the variables currently in use.  

To change the value of an existing variable or to create and set a new variable, we use `export`. For example, to set a variable called `workDir` to a directory called here within your home directory, the command would be:

`export workDir=$HOME/here`

Once this environment variable is set, you are able to use this. For example, to change to this directory, the command would be:

`cd $workDir`

For something like PATH where you really do not want to overwrite what values are already stored, you can append values with

`export PATH=$PATH:/new/dir/path/`

In lists of values, the colon (`:`) is used as the delimiter. The dollar sign (`$`) is used to reference variables, so that export command essentially appends the new directory to the list of existing directories searched for executables. It is possible to prepend as well, which may come in handy if you compile a different version of an existing command.  

For more general reading on environment variables in Linux, see these pages on [variables](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html) and [environmental variables](https://en.wikipedia.org/wiki/Environment_variable).  

The environment variables allow for script portability between different systems. By referencing variables like the home directory ($HOME) you can generalize a script’s functionality to work across systems and accounts.

|Variable Name|Description|
|--- |--- |
|USER|Your user ID|
|HOSTNAME|The name of the server that the script is being run on|
|HOME|Your home directory|
|WORK|Your work directory|
|SCRATCH|Your scratch directory|
|TMPDIR|The directory in which a job's temporary files are placed (created and deleted automatically)|


##### <span class="titlemark">5.1.4</span> References

The Linux terminal and submitting jobs are not unique to Roar. You can find many different training resources online for these. The Linux foundation offers [free training](https://training.linuxfoundation.org/free-linux-training). Lots of great information and tutorials for everyone from beginner Linux user to advanced users can be found [here](https://www.linux.org/pages/download/). Linux has been around for a long time. Therefore, any problem you might be having, someone has probably already had. It is always worthwhile to look around [stack exchange](https://unix.stackexchange.com/) to see if your question has already been answered.

  

#### 5.2 Module System

Roar now uses the Lmod environment modules system. Environment Modules provide a convenient way to dynamically change the users environment through modulefiles. This includes easily adding or removing directories to the `PATH`, `LD_LIBRARY_PATH`, `MANPATH`, and `INFOPATH` environment variables. A modulefile contains the necessary information to allow a user to run a particular application or provide access to a particular library. All of this can be done dynamically without logging out and back in. Modulefiles for applications modify the users path to make access easy. Modulefiles for library packages provide environment variables that specify where the library and header files can be found. Learn more about modules on [TACC’s website](https://www.tacc.utexas.edu/research-development/tacc-projects/lmod).

##### <span class="titlemark">5.2.1</span> Module Families

Roar uses module families for compilers and parallelization libraries. Modules that are built with a parent module, such as a compiler, are only available when the parent module is loaded. For example, the version of LAPACK built with the gcc module is only available when the gcc module is located.

A good way to illustrate how the module families work is to view the available modules before a family is loaded as well as after. You can do this with the gcc family by inspecting the output of

<pre class="script">module purge

module avail

module load gcc/8.3.1

module avail

`

##### <span class="titlemark">5.2.2</span> Using Modules

You can load modules into your environment with the command with the module load command. For example, to load the gcc module, you can use the command:

`module load gcc/8.3.1`

Note that the version number is not required. Each software will have a default module that will be loaded if no version number is provided. However, it is recommended that you put the version number so that you know and have a record of what version is being used.  

You can view the modules that you currently have open using the module list command:

`module list`

You can also unload modules that you do not need in the same way:

`module unload gcc/8.3.1`

It is also possible to remove all of your loaded modules at once using purge:

`module purge`

##### <span class="titlemark">5.2.3</span> Querying Modules

You can view the available modules using the command:

`module avail`

Note that this only looks at the available modules, which may be limited by module family based on modules are currently loaded. You can search all of the modules using `module spider`. For example, to search for VASP, you can use the command

`module spider vasp`

which will search through all module names and module files to return anything related to vasp.  

The module can be used to give you information about the software using the module show command. For  
example, the information about the hdf5 module, which was built using the gcc module, can be seen using the commands:

<pre class="script">module load gcc/8.3.1

module show hdf5/1.10.7

`

The output of this is shown:

<pre class="script">---------------------------------------------------------------------

/opt/aci/modulefiles/Compiler/gcc/8.3.1/hdf5/1.10.7.lua:

---------------------------------------------------------------------

help([[HDF5 is a unique technology suite that makes possible the management of extremely large and complex data collections. The HDF5 technology suite includes: A versatile data model that can represent very complex objects and a variety of metadata. A completely portable file format with no limit on the number or size of data objects in the collection. A software library that runs on a range of computational platforms, from laptops to massively parallel systems, and implements a high-level API with C, C++, Fortran 90, and Java interfaces. A rich set of integrated performance features that allow for access time and storage space optimizations. Tools and applications for managing, manipulating, viewing, and analyzing the data in the collection.
]])

whatis("Description: HDF5 is a unique technology suite that makes possible the management of extremely large and complex data collections.")

whatis("URL: https://support.hdfgroup.org/HDF5/")

prepend_path("PATH","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1/bin")

prepend_path("LD_LIBRARY_PATH","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1/lib64")

prepend_path("C_INCLUDE_PATH","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1/include")

prepend_path("CPLUS_INCLUDE_PATH","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1/include")

prepend_path("LIBRARY_PATH","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1/lib64")

pushenv("HDF5","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1")

pushenv("HDF","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1")

`

Note that this tells you some information about the software, gives a website for more help and shows the environment variables that are modified. The environment manipulation section can be very helpful for users who are compiling codes and linking to libraries as these paths indicate where the relevant objects may be found.  

##### <span class="titlemark">5.2.4</span> Controlling Modules Loaded at Login

Most shells have a configuration file that allows you to set aliases (nicknames for commands both simple or complex), set environment variables, and automatically execute programs and commands. In this case we are interested in the last mentioned feature: automating commands at login. For BASH there are two files at play: `~/.bash_profile` and `~/.bashrc.` To force your bashrc to be sourced in every opened terminal and SSH session, include this code in your bash_profile:

`if [ -f ~/.bashrc ]; then

. ~/.bashrc

fi
`

Once that has been done, you can add whatever automated module loads you want in the .bashrc file by including:

`module load <module name>/<version>`

The version specification is optional, excluding it will cause whatever the default version is to be loaded. Other shells have similar configuration methods that are detailed in online documentation.

  

#### 5.3 Connecting to ACI-b

Users can connect to ACI-b with the hostname

`submit.aci.ics.psu.edu`

using `ssh`. Users  connecting with ssh are encouraged to use the secure x-window forwarding flag (`-Y`) if x-windows will be used during the session. Note that the screen may not show * symbols for each keystroke when your password is being entered. (In this example, the username is "abc123".)

`ssh -Y abc123@submit.aci.ics.psu.edu`

  

#### 5.4 Connecting to ACI-i

Users connect to ACI-i with Open OnDemand.

  

#### 5.4.1 Open OnDemand

Open OnDemand lets you utilize Penn State’s high performance computing resources in a graphical, menu-based environment that doesn’t require using an ssh client. Interacting with Roar with Open OnDemand looks and feels like the desktop or web-based applications you’re used to.

Open OnDemand is accessed through your web browser, so there’s nothing to download or install.  
Simply go to this web address:

PORTAL.ACI.ICS.PSU.EDU

**Note:** When accessing Roar on Open OnDemand, you’ll see a CILogon screen before you can enter your Penn State ID and password. Simply click the **Log On** button to proceed.

### Introduction to Using Open OnDemand on Roar (formerly known as ICDS-ACI)

<iframe loading="lazy" src="https://www.youtube.com/embed/ekiz0o94pwQ" allowfullscreen="allowfullscreen" width="560" height="315" frameborder="0"><span data-mce-type="bookmark" style="display: inline-block; width: 0px; overflow: hidden; line-height: 0;" class="mce_SELRES_start">﻿</span></iframe>

  

#### 5.5 Connecting to HPRC

Users can connect to HPRC from ACI-b head nodes, with the host name

`submit.aci.ics.psu.edu`

…using ssh. Users connecting with ssh are encouraged to use the secure x-window forwarding flag (-Y) if x-windows will be used during the session. Note that the screen may not show * symbols for each keystroke when your password is being entered. (In this example, the username is "abc123".)

`ssh -Y abc123@submit.aci.ics.psu.edu`

  

#### 5.6 Transferring Data to and from Roar

There are many different ways to transfer data to and from Roar.  

##### <span class="titlemark">5.6.1</span> Command line File Transfer

There are two main command-line SSH commands to transfer files: `scp` and `sftp`. `scp` is a non-interactive command that takes a set of files to copy on the command line, copies them, and exits. `sftp` is an interactive command that opens a persistent connection through which multiple copying commands can be performed.  

**scp**  
To copy one or more local files up to the Roar server, the `scp` syntax would be:

`scp local_file <username>@datamgr.aci.ics.psu.edu:<target_directory>`

The default port for scp is set to 22\. If you use this port you will be automatically directed to Duo Push authentication during 2FA.  

For user abc123 to copy the local files foo.c and foo.h into their home directory on the host aci-b.aci.ics.psu.edu, the following command would be used:

`[abc123@local ~]$ scp foo.c foo.h abc123@datamgr.aci.ics.psu.edu:~/.`

The <span class="cmbx-10">-r</span> (recursive) flag can be used to transfer directories.

`[abc123@local ~]$ scp -r dirA abc123@datamgr.aci.ics.psu.edu:~/.`

Users can also copy files from Roar onto their own computer using

`[abc123@local ~]$ scp abc123@datamgr.aci.ics.psu.edu:~/fileA .`

**sftp**  
`sftp` is an interactive command that uses the same syntax as a standard command-line ftp client. It differs from a standard ftp client in that the authentication and the data transfer happen through the SSH protocol rather than the FTP protocol. The SSH protocol is encrypted whereas the FTP protocol is not.  

There are a number of basic commands that are used inside of `stfp`:

*   `put filename`: uploads the file filename
*   `get filename`: downloads the file filename
*   `ls`: lists the contents of the current remote directory
*   `lls`: lists the contents of the current local directory
*   `pwd`: returns the current remote directory
*   `lpwd`: returns the current local directory
*   `cd directory`: changes the current remote directory to directory
*   `lcd directory`: changes the current local directory to directory

The syntax for calling `sftp` is:

`sftp username@hostname`

To choose between different options for 2FA you have to set the port to 1022 using P flag similar to `ssh`.  

An example `sftp` session, with both the inputs and outputs, would be:

<pre class="script">[abc123@local ~]$ sftp abc123@submit.aci.ics.psu.edu

Connecting to submit.aci.ics.psu.edu...

Password: <user abc123 password>

# Duo Push authentication

Connected to aci-b.aci.ics.psu.edu.

sftp> pwd

Remote working directory: /storage/home/abc123

sftp> lpwd

Local working directory: /home/abc123

sftp> cd work/depot

sftp> pwd

Remote working directory: /storage/work/abc123/depot

sftp> lcd results

sftp> lpwd

Local working directory: /home/abc123/results

sftp> ls -l

-rw-r--r--

1 root

root

5 Mar

3 12:08 dump

sftp> lls -l

total 0

sftp> get dump

Fetching /storage/work/abc123/depot/dump to dump

/storage/work/abc123/depot/dump

100%

5

0.0KB/s

0.0KB/s

00:00

sftp> lls -l

total 4

-rw-r--r-- 1 abc123 abc123 5 Mar

3 12:09 dump

sftp> put data.txt

Uploading data.txt to /storage/work/abc123/depot/data.txt

data.txt

100%

15

0.0KB/s

sftp>

`

**rsync**  
`rsync` is a utility that can be used to copy files and for keeping files the same on different systems as a rudimentary version control system. The benefit to using `rsync` over `scp` is that if an `scp` is stopped for any reason (poor wireless connection, large files, etc) the restart will begin as if no files were copied over. The `rsync` utility will only copy the files that were not successfully moved over in the previous command. Once you have SSH access between two machines, you can synchronize dir1 folder ( home directory in this example) from local to a remote computer by using syntax:

`rsync -a ~/dir1 username@remote_host:destination_directory`

where remote host is the Roar host name as in scp command. If dir1 were on the remote system instead of the local system, the syntax would be:

`rsync -a username@remote_host:/home/username/dir1 place_on_local_machine`

If you are transferring files that have not been compressed yet, like text files, you can reduce the network transfer by adding compression with the `-z` option:

`rsync -az source_dir username@remote_host:target_dir`

The -P flag is very helpful. It combines the flags -progress and -partial. The former gives you a progress bar for the transfers and the latter allows you to resume interrupted transfers:

`rsync -azP source_dir username@remote_host:target_dir`

In order to keep two directories synchronized it is necessary to delete files from the destination directory if they are removed from the source. rsync does not delete anything from the destination directory by default. To change this behavior use the `-delete` option:

`rsync -a --delete source_dir username@remote_host:taget_dir`

If you wish to exclude certain files or directories located inside a directory you are syncing, you can do so by specifying them in a comma-separated list following `-exclude=` option:

`rsync -a --exclude=pattern_to_exclude source_dir username@remote_host:target_dir

`

One common pitfall that can affect users transferring files between systems with different usernames and groups can be the permissions assigned to the files being `rsync`-ed. The `--chmod` option can be used both to set the permissions for the user, group and other independently, as well as to set any directory permissions for inheritance of files created within the directory after the transfer is complete.  Multiple commands can be strung together using commas. For example, the following will provide full permissions for the user, read and execute permissions for others in the group and will cause all of the future files created within any directories being transferred to inherit the group that the directory has.

`rsync -a--chmod u=rwx,g=rx,Dg+s source_dir username@remote_host:target_dir`

##### <span class="titlemark">5.6.2</span> Graphical File Transfer

WinSCP and FileZilla provide a free secure FTP (SFTP) and secure copy (SCP) client with graphical interface for Windows, Linux and Mac using SSH, allowing users to transfer files to and from our cluster file system using a drag-and-drop interface. Please use either the SCP or SFTP protocol with port 22 with the data manager nodes

`datamgr.aci.ics.psu.edu`

to transfer files. Please note that your two factor authentication is required.  

For more information, please visit the [WinSCP homepage](http://winscp.net/eng/index.php) or the [FileZilla homepage](https://filezilla-project.org/).  

You can see the connection process in this [ICDS tutorial video](https://www.youtube.com/watch?v=pOJaKeA89lI&t=2s).  

It is also possible to use the online interface for either Box or DropBox within Firefox on ACI-i for users who logged on with Open OnDemand. It is not currently possible to sync to your storage space on Roar at this time.  

##### <span class="titlemark">5.6.3</span> Web-based Services

Globus is one of the recommended methods of transferring very large data. Most HPC centers have endpoints set up allowing for optimized transfer between large centers. Users can also install personal endpoints on their own machines using Globus Connect. Its web interface allows users to transfer files from a desktop or mobile device.  

Users must sign up for a [globus](http://globus.org) [account](http://globus.org) as this is a separate service from Roar. An endpoint is a location to/from which the files are to be transferred. There are 2 types of endpoints: server endpoints (like Roar) and personal endpoints (user’s laptop). To save or bookmark endpoints go to Manage Endpoints section on the globus webpage (you have to be logged in). Then click add Globus Connect Personal In Step 1 you have to define the name for your personal endpoint and click on Generate Setup Key. Copy the key to the clipboard. In Step 2 you have to download and install Globus Connect Personal app appropriate for your OS. To finish the installation you will be asked to paste the generated key which you copied to the clipboard. Each time you want to transfer file you will have to have the Globus Connect Personal running on your local computer. If you do not have a Globus account, create one [here](https://www.globus.org.). Set up a free Globus Online account using your PSU ID. If you wish to use Globus to transfer data to/from your local computer, install the Globus Connect Personal tool on your computer. More information on the Instructions for Installing Globus Connect Personal tool for linux can be found [here.](https://docs.globus.org/how-to/globus-connect-personal-linux/) Instructions for [mac](https://docs.globus.org/how-to/globus-connect-personal-mac/) and [windows](https://docs.globus.org/how-to/globus-connect-personal-windows/) are also available.

On the Globus Start Transfer page, choose one of three Roar end points (for example `PennState_ICS-ACI_DTN_EndPnt_01`) as the end point on one side. This will pull up an authentication window. Use your Penn State ID for the user name, and your Penn State ID password for the pass phrase. This will set up an authenticated session.  

Select and authenticate with the other endpoint for your transfer, and initiate your transfer. You may need to click on refresh list if you can’t see the transferred files despite the transfer has completed.  

There are other specialized data-transfer software available for specific needs, such as Aspera. Contact the iAsk center if you have any questions regarding using one of these specialized tools on ACI.  

##### <span class="titlemark">5.6.4</span> File Permissions

File permissions can be seen using the `-l` flag for ls:

`ls -l`

The letters at the beginning indicate the file or folder permissions while the third and fourth columns show the owner and group associated with the file. The letters used are typically rwx, for read, write and execute. These are grouped in sets of three, the first set for the owner, the second for the group and the third for the entire world. Users may change permissions using the chmod command. An excellent overview of how to change permissions using chmod can be found [here.](http://catcode.com/teachmod/)

Users may also want to change the group of their files using the `chgrp` command.

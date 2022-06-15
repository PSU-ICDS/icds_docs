---
title: Handling Data
---

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

```
[abc123@local ~]$ sftp abc123@submit.aci.ics.psu.edu

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
```

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

`rsync -a --exclude=pattern_to_exclude source_dir username@remote_host:target_dir`

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

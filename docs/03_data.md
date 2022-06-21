---
title: Data Transfer and Storage
---

There are many different ways to transfer data to and from ICDS storage locations.
The characteristics of your data and desired workflow will dictate which solution 
would be best.

# Data Storage Locations and Quotas

ICDS offers three tiers of storage: free, Active, and Nearline. All users of ICDS
are eligible to the free tier including `home`, `work`, and `scratch` directories.
Extended storage solutions such as Actie or Nearline are available to users with 
paid allocations.

There are several file storage options for users, each with their own quotas and 
retention policies. These are available for users to optimize for specific purposes.

Please note that while both Roar and Roar Collab have similar file storage 
locations, **each cluster has independent file systems and files cannot be accessed 
between them**. Information on transferring files between Roar, Roar Collab, 
and Nearline storage can be found in [Transferring Data to and between ICDS 
resources](#transfer).

|Storage|Quota|Backup Policy|
|--- |--- |--- |
|Home|16 GB  
500,000 files|Daily snapshot|
|Work|128 GB  
1 million files|Daily snapshot|
|Scratch|No space quota  
1 million files|No backup  
Files purged after 30 days|
|Group|Allocation dependent|No backup|
|Nearline|Allocation dependent|No backup|

Group storage directories are created when an active storage allocation is 
established. If you are interested in setting up a storage or compute allocation, 
please contact us at [icds@psu.edu](mailto:icds@psu.edu) for more information.


## Roar Storage Locations

|Storage|Location|
|--- |--- |
|Home|`/storage/home/<user_id>`|
|Work|`/storage/work/<user_id>`|
|Scratch|`/scratch/<user_id>`|
|Group|`/storage/group/<PI_id>/default`|

## Roar Collab Storage Locations

|Storage|Location|
|--- |--- |
|Home|`/storage/home/<user_id>`|
|Work|`/storage/work/<user_id>`|
|Scratch|`/gpfs/scratch/<user_id>`|
|Group|`/gpfs/group/<PI_id>/default`|

## WIP: Nearline Archival Storage

Nearline storage is only accessable from the Roar Data Management nodes.



## WIP: Data Management Nodes

To transfer data, please utilize the Data Management nodes as they have been 
optimized for effiecent data transfer.

To access the Data Management nodes:



<a name="transfer"></a>
# Transferring Data to, from, and between ICDS Resources

Use of traditional remote file transfer tools such as [Command Line Tools] 
and [drag and drop applications](#gui-transfer) are supported. Additionally, 
ICDS offers [Globus optimized Endpoints](#globus). Globus is a robust data 
transfer service and is the recommended solution for large scale data transfers.

To use other specialized data-transfer software, such as Aspera. [Contact our 
iASK Support Team](mailto: iask@ics.psu.edu) for additional information and 
assistance.

<a name="cli-transfer"></a>
## Command Line Tools

There are several command-line tools that can be used to transfer files. The 
common of these are `scp`, `sftp`, and `rsync`. Basic usage of these commands 
follows, but users are encouraged to [read the man file on these tools]
(https://itsfoss.com/linux-man-page-guide/) for more
details.

### scp

The secure copy utility or `scp` can be used to transfer files between local and 
remote resources. The basic `scp` syntax is:

	$ scp <source user_name>@<source hostname>:<path to file(s)> 
	<target user_name>@<target hostname>:<path to target storage>
	
To copy from or to a local machine, the `user_name` and `hostname` details can 
be left blank. For example, if `user` was transferring `file.txt` from his local 
machine to his work directory on Roar Collab, the command would be:

	$ scp file.txt user@submit.hpc.psu.edu:/storage/work/user/

By default, 2FA will send a push notification to your mobile device.

### sftp

`sftp` is an interactive command that uses the same syntax as a standard 
command-line ftp client. It differs from a standard ftp client in that the 
authentication and the data transfer happen through the (encrypted) SSH protocol 
rather than the (not encrypted) FTP protocol.

The syntax for calling `sftp` is:

	$ sftp <user_name>@<hostname>

There are a number of basic commands that are used inside of `stfp`:

*   `put filename`: uploads the file filename
*   `get filename`: downloads the file filename
*   `ls`: lists the contents of the current remote directory
*   `lls`: lists the contents of the current local directory
*   `pwd`: returns the current remote directory
*   `lpwd`: returns the current local directory
*   `cd directory`: changes the current remote directory to directory
*   `lcd directory`: changes the current local directory to directory


To choose between different options for 2FA you have to set the port to 1022 
using P flag similar to `ssh`. 

### rsync

RSYNC SHOULD NOT BE USED WITH NEARLINE!

`rsync` is a utility that can be used to copy files and for keeping files the 
same on different systems as a rudimentary version control system. The benefit 
to using `rsync` over `scp` is that if an `scp` is stopped for any reason 
(poor wireless connection, large files, etc) the restart will begin as if no 
files were copied over. The `rsync` utility will only copy the files that were 
not successfully moved over in the previous command. Once you have SSH access 
between two machines, you can synchronize dir1 folder ( home directory in this 
example) from local to a remote computer by using syntax:

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

One common pitfall that can affect users transferring files between systems with 
different usernames and groups can be the permissions assigned to the files being 
`rsync`-ed. The `--chmod` option can be used both to set the permissions for the 
user, group and other independently, as well as to set any directory permissions 
for inheritance of files created within the directory after the transfer is 
complete.  Multiple commands can be strung together using commas. For example, 
the following will provide full permissions for the user, read and execute 
permissions for others in the group and will cause all of the future files 
created within any directories being transferred to inherit the group that the 
directory has.

`rsync -a--chmod u=rwx,g=rx,Dg+s source_dir username@remote_host:target_dir`


<a name="gui-transfer"></a>
## Drag and Drop Tools

WinSCP and FileZilla provide a free secure FTP (SFTP) and secure copy (SCP) 
client with graphical interface for Windows, Linux and Mac using SSH, allowing 
users to transfer files to and from our cluster file system using a drag-and-drop 
interface. 

When using these tools, please ensure you are using either the SCP or SFTP 
protocol to connect to the [Data Management nodes](#datamgr) using port 22.

For more information, please visit the [WinSCP homepage]
(http://winscp.net/eng/index.php) or the [FileZilla homepage]
(https://filezilla-project.org/).  

You can see the connection process in this [ICDS tutorial video]
(https://www.youtube.com/watch?v=pOJaKeA89lI&t=2s).  



<a name="globus"></a>
## Using Globus

Users can also use [Globus](http://globus.org/) for robust, user-friendly file 
transfers between Roar, Roar Collab, Nearline storage, and personal machines. 
Established Globus endpoints are available on ICDS’s data manager nodes for 
optimized data transfer speeds.

ICDS offers the following endpoints for Globus users:

|Resource|File System Access|Endpoint Name(s)|
|--- |--- |--- |
|Roar|Scratch, Home, Work, Group/Active, Nearline|PennState_ICS-ACI_DTN_EndPnt_01  
PennState_ICS-ACI_DTN_EndPnt_02  
PennState_ICS-ACI_DTN_EndPnt_03|
|Roar Collab|Home, Work, Group/Active|PennState_ICDS_RC|

To transfer data between established endpoints, like those specified in the table 
above, please see [How to Login In and Transfer Files with Globus]
(https://docs.globus.org/how-to/get-started/).

To transfer data to and from and a personal machine or lab server, please see 
the documentation on installing and configuring Globus Connect Personal:

- `For Windows: [https://docs.globus.org/how-to/globus-connect-personal-windows](https://docs.globus.org/how-to/globus-connect-personal-windows)
- `For Mac OS X: [https://docs.globus.org/how-to/globus-connect-personal-mac/](https://docs.globus.org/how-to/globus-connect-personal-mac/)
- `For Linux: [https://docs.globus.org/how-to/globus-connect-personal-linux](https://docs.globus.org/how-to/globus-connect-personal-linux)




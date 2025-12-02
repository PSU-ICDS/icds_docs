# Transferring files

Computational workflows often require files 
on Roar, archival storage, 
OneDrive, or your laptop or desktop machine
to be transferred -- copied from one place to another.

Multiple tools exist to perform these file transfers.
No single tool is best for all cases;
below, we recommend methods, 
and list approximate transfer rates for large files.

| Transfer | Method | Rate (MB/sec) |
| ---- | ---- | ---- |
| Roar &harr; Archive | Globus | 50 |
| Roar &rarr; OneDrive | Firefox or Globus | 50 | 
| OneDrive &rarr; Roar | Firefox or Globus | 10 |
| Roar &harr; laptop | Portal Files Menu (< 1GB) | 25 |
| Roar &harr; laptop | Cyberduck or FileZilla | 15 |
| Roar &harr; laptop | Globus Personal Collection (> 1GB) | 50 |
| OneDrive &harr; laptop | Web Access |20 |

(Transfer rates may be slower, 
if limited by intervening network or storage speeds.)

## Portal

The [Portal][portal] top menu under Files/Home
opens a window that enables convenient file transfer 
between Roar and your laptop.
With this utility, small files can be conveniently moved, edited, uploaded, and downloaded. 
[portal]: https://portal.hpc.psu.edu/pun/sys/dashboard

Use this method only for moving small (<1 GB) files;
for larger files, use [Globus](#globus).

!!! warning "Upload Button Issues"
	The "Upload" button on the Portal does not work properly when transfering files above 1GB. 
	Instead, use the "Globus" button, which accesses the [Globus](#globus) interface.

## Firefox

With Firefox, you can access OneDrive and other such sites,
and upload and download files. <br>
From the [Portal Interactive Desktop][portalID],
select Web Browser from the Applications menu.
[portalID]: ../getting-started/connecting.md#portal

Firefox is also available via `ssh -X`, after loading its module with 
`module load firefox`.   
From the command line, execute `firefox`.

Users may need to set the default browser manually using either:

- in their .bashrc file: 
```bash
BROWSER=/storage/icds/tools/sw/firefox/firefox 
```

- In an Interactive Desktop session, Applications > Settings > Settings Manager, then select Default Applications. Under the Internet tab, there is a field for Web Browser. Firefox is located at /storage/icds/tools/sw/firefox/firefox

!!! note "Using Firefox in Interactive Desktops"
    When using Firefox within an Interactive Desktop session, the operating system may ask for a path when you attempt to save or upload files. You can navigate to your storage directories using paths like `/storage/home/<username>` or `/storage/work/<username>`.

## Globus

Globus is a web-based tool designed for robust transfers of large files.
It can move files from Roar to filesystems outside Penn State,
including our OneDrive accounts.
Globus is interactive, but time-consuming file transfers 
can be submitted as batch jobs.
To get started, go [here][globus].
[globus]: https://docs.globus.org/how-to/get-started/

Globus moves files between named "collections".
Many institutions have established collections;   
ICDS has endpoints for Roar, Archive, and OneDrive:

| Filesystem | Endpoint |
| ---- | ---- |
| Roar | Penn State ICDS RC |
| Archive | Penn State ICDS Archive |
| PSU OneDrive | Penn State ICDS OneDrive |

To transfer files to or from a laptop,
use the upload/download buttons on the Globus [web interface][globusweb].
[globusweb]:  https://www.globus.org

 
### Globus Personal Collection

For users who need to transfer large files (typically larger than 1 GB) between the Roar system and their personal computer, Globus Connect Personal provides a powerful and convenient solution.
Globus Connect Personal allows you to turn your personal computer (laptop or desktop) into a Globus endpoint, also known as a personal collection. Once set up, you can securely transfer files between your computer and other Globus collections.

To get started, download and install the Globus Connect Personal client for your operating system:
available for [Linux](https://docs.globus.org/globus-connect-personal/install/linux/),
[macOS](https://docs.globus.org/globus-connect-personal/install/mac/), and
[Windows](https://docs.globus.org/globus-connect-personal/install/windows/).

### Globus Guest Collections

In addition to providing a robust data transfer option, Globus can also be used to share 
data with collaborators by creating 
[Guest Collections](https://docs.globus.org/how-to/guest-collection-share-and-access/). 
Collections can be set up with a variety of sharing options from complete public access 
to individual user-level permission levels.

!!! danger "ICDS does not monitor what is shared using Globus Collections"

	Please be mindful that your Collection is set up using appropriate sharing and 
	permission settings to avoid unintentionally sharing private data.


Roar users can set up their own Guest Collections using the Globus interface. However, 
due to security concerns, there are restrictions on what is enabled by default and who is 
authorized to create the Collection. 

- User-level Collections can be created anywhere within the user’s work directory.
- Group-level Collections can only be created by the faculty owner and must be within the 
default directory of the group storage. 

#### Globus Collections Authorized Directories

| Filesystem location | Authorized User |
| ---- | ---- |
| `/storage/work/$USER`	| Directory Owner <br> (where $USER matches the Penn State ID of the Directory Owner) |
| `/storage/group/$USER/default/` | PI / Faculty Owner <br> (where $USER matches the Penn State ID of the Faculty Owner) |


!!! warning "Permission Errors"

	Users can create Guest Collections anywhere in the Roar filesystem that Globus 
	has access to, however “Permission Denied” errors will occur if they are created 
	outside of the authorized directories.

#### Exceptions for Shares

For sharing options outside of the restrictions above, please contact Client Support for 
possible solutions.

!!! tip "Custom Collection locations"

	Collections inside group storage with non-standard naming conventions 
	(where $USER (above) is not a Penn State ID) will not work by default. 
	Please contact us to set up an exception.

## sftp

[`sftp`][sftp] (secure file transfer protocol) is a Unix tool
for file transfers.  To launch sftp,
[sftp]: https://man7.org/linux/man-pages/man1/sftp.1.html
```
sftp <username>@<address>
```
where `<address>` is the address of a "remote machine",
and `<username>` is your userid on that machine.
For sftp *to* Roar, the address is `submit.hpc.psu.edu`,
the same as for ssh logon.

Just as for ssh logon, you will be prompted 
for your password on the remote machine,
and multi-factor authentication (MFA)
if the remote machine requires it.

sftp is an interactive program.
Once logged on, you can copy files 
from the local machine to the remote with `put <filename>`,
and from the remote machine to the local with `get <filename>`.

When sftp launches, your location on the local machine
is the directory in which you launched sftp,
and your location on the remote machine is your home directory.
To control where on the remote machine files go to and come from,
within sftp you can navigate on the remote machine with `cd`
and list files with `ls`. 
Likewise, within sftp you can navigate on the local machine
with "local" versions of these commands, `lcd` and `lls`.

!!! tip ""
     "Graphical" sftp clients for your laptop
     can be used for file transfer to Roar, 
     as well as to OneDrive or other cloud storage providers.
     Two popular options for both OS X and Windows are
     [Cyberduck][cyberduck] and [FileZilla][filezilla].
[cyberduck]:https://cyberduck.io
[filezilla]:https://filezilla-project.org

## rsync

Sometimes, you want to copy a directory of files 
from one place to another,
and then later *update* the copy
with any changes made to the originals,
so that the copy reflects the current version.
If the directory contains many files but only a few are changed,
it would be nice to have a program that automatically updates
only the changed files. [`rsync`][rsync] does this:
[rsync]: https://linux.die.net/man/1/rsync
```
rsync <options> <source-path> <destination-path>
```
copies files from `<source-path>` to `<destination-path>`,
*and deletes files if necessary*,
to make the destination the same as the source.
Later, if you change files on `<source-path>`,
run rsync again to update files on `<destination-path>`.

rsync has several important options:

- `a` – "archive" mode; traverses directories recursively
- `v` – "verbose"; reports which files are copied
- `z` – "zips" (compresses) the files on transfer
- `h` – "human readable" reporting

The source and destination can be on the same filesystem,
or they can be different machines entirely.
From a Unix command line on your laptop 
(running Linux or OS X),
```
rsync /work/newData abc123@submit.hpc.psu.edu:/storage/work/abc123/toAnalyze/
```
which will prompt for your password and MFA.

Note that the *destination* pathnames end with a `/`;
this signifies that the copied files will go into the directory `toAnalyze`.
For more examples, visit [Tecmint][tecmint].
[tecmint]: https://www.tecmint.com/rsync-local-remote-file-synchronization-commands/

!!! warning ""
     With rsync, the source is the original, and the destination is the copy.
     Don't reverse direction, or you will confuse rsync and yourself,
     and wind up clobbering or deleting files.

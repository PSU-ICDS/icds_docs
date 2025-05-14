# Command Line File Transfers

Most command line utilities can be used on Roar Collab.

## sftp

[`sftp`][sftp] (secure file transfer protocol) is a Unix tool
for file transfers.  To launch sftp,
[sftp]: https://man7.org/linux/man-pages/man1/sftp.1.html

```
sftp <username>@<address>
```
where `<address>` is the address of a "remote machine",
and `<username>` is your user id on that machine.
For sftp *to* Collab, the address is `submit.hpc.psu.edu`,
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
is the folder in which you launched sftp,
and your location on the remote machine is your home directory.
To control where on the remote machine files go to and come from,
within sftp you can navigate on the remote machine with `cd`
and list files with `ls`.
Likewise, within sftp you can navigate on the local machine
with "local" versions of these commands, `lcd` and `lls`.

!!! tip ""
     "Graphical" sftp clients for your laptop
     can be used for file transfer to Collab,
     as well as to OneDrive or other cloud storage providers.
     Two popular options for both macOS and Windows are
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

- `-a` "archive" mode traverses directories recursively
- `-v` "verbose" reports which files are copied
- `-z` "zips" (compresses) the files on transfer
- `-h` "human readable" reporting

The source and destination can be on the same filesystem,
or they can be different machines entirely.
From a Unix command line on your laptop
(running Linux or macOS),
```
rsync /work/newData abc123@submit.hpc.psu.edu:/storage/work/abc123/toAnalyze/
```
which will prompt for your password and MFA.

Note that the *destination* pathnames end with a `/`;
this signifies that the copied files will go into the folder `toAnalyze`.
For more examples, visit [Tecmint][tecmint].
[tecmint]: https://www.tecmint.com/rsync-local-remote-file-synchronization-commands/

!!! warning ""
     With rsync, the source is the original, and the destination is the copy.
     Take care to ensure you are identifying them correctly.

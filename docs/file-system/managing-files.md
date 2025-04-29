# Managing files

Common tasks on any filesystem include navigating to a directory; listing the files; 
creating folders; and copying, moving, renaming, and deleting files and folders.
In classic Linux, these tasks are all performed with command line tools: 

- `cd` (change directory)
- `ls` (list files) 
- `mkdir` (make directory)
- `rmdir` (remove directory)
- `cp` (copy)
-  `mv` (move)
-  `rm` (remove)

Part of learning [Linux](../getting-started/tips-for-beginners.md/#roar-uses-linux)
is becoming familiar with these commands. 

If you prefer a more "graphical" user interface, two options exist.

The [Thunar][thunar] graphical file manager is available
from the Portal Interactive Desktop
( menu item Applications/Accessories/Thunar File Manager)
or an `ssh -X` terminal session (`thunar` at the command line).
[thunar]: https://docs.xfce.org/xfce/thunar/start

Alternatively, the [Portal][portal] top menu under Files/Home
opens a window that enables file management
(moving, copying, renaming, making and deleting folders).
[portal]: https://portal.hpc.psu.edu/pun/sys/dashboard

## File permissions

If you have access to group space on Roar, located at
`/storage/group/<PIuserID>/default`,
the default file permissions and ownership are
```
drwxr-s-- 2 root <PIuserID>
```

The `s` setting in the group permissions means 
every file and folder created within the group folder
will have the same group permissions.
However, files created elsewhere and moved into group 
have the permissions they were created with.
To change them, use [`chmod`][chmod]:
[chmod]: https://man7.org/linux/man-pages/man1/chmod.1p.html
```
chmod g+r <filespec>
```
More generally, chmod can be used to add or remove (+ or -) 
permissions to read (r), write (w), or execute (x),
for the user (u), group (g), or others (o).

## Packing files

To copy or transfer many files,
or an entire directory of files, possibly with subdirectories,
it is convenient to first make a single large file of the entire contents,
using the Unix command `tar`.  The command
```
tar -cf <tarfilename>.tar <filespec>
```
creates (`-c`) a single .tar file (`-f`) (sometimes called a "tarball"),
containing the entire contents of `<filespec>`.
With option `-v` (as in `tar -cvf`), tar operates "verbosely", 
listing every file added.

To make a tarball of everything in the current directory:
```
tar -cf myTar.tar *
```

tar with option `-z` (as in `tar -czf`)
makes a "zipped" (compressed) tarball.
Compressing text files often makes the tarball much smaller;
compressing binary or image files is usually pointless.

To unpack a tarball (option `-x` for "extract"):
```
tar -xf myTar.gz 
```



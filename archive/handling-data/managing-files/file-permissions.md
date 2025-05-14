
## File permissions

File permissions are settings on files and directories that 
control who has access to read, write, and execute (search in the case of directories) them. These settings can be 
set for user, group, and other (everyone else).

For example, group space on Collab, located at
`/storage/group/<PIuserID>/default`,
for which the default file permissions and ownership are shown in this output of `ls -l`

```
drwxr-s-- 2 root <PIuserID>
```
The `d` indicates this is a directory. The next 3 characters control permissions for the owner. The subsequent 3 control
permissions for the group. And the final 3 control permissions for others (everyone else).
The `s` setting in the group permissions means 
every file and folder created within the group folder
will have the same group as this parent directory.
To change permissions use [`chmod`][chmod]:
[chmod]: https://man7.org/linux/man-pages/man1/chmod.1p.html
More generally, chmod can be used to add or remove (+ or -) 
permissions to read (r), write (w), or execute (x),
for the user (u), group (g), or others (o).

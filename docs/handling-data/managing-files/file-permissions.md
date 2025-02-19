
## File permissions

File permissions are settings that can be set on files and directories that 
control who has access to read, write, and execute them. These settings can be 
set at the user, group, or global level.

For example, group space on Collab, located at
`/storage/group/<PIuserID>/default`,
for which the default file permissions and ownership are

```
drwxr-s-- 2 root <PIuserID>
```

The `s` setting in the group permissions means 
every file and folder created within the group folder
will have the same group read `r` permission.
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

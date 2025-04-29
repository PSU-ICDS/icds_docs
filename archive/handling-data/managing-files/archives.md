# Creating File Archives using tar

Compressing or archiving files is the act of packing one or more files and directories into a single 
compressed file. This is commonly done to simplify file navigation and wrangling, making file transfers
more efficient, and reducing inode quota limits. Compressing or "packing" files prior to transfer or moving 
them to long term storage is recommended.

To create an archive on Roar Collab, the `tar` command can be used with th `-c` argument:

```
tar -cf <tarfilename>.tar <directory_or_file_list>
```

Adding the `-z` option further compresses the archive. For example, to make a compressed archive called 
"myTar.tar" containing everything in the current directory:

```
tar -czf myTar.tar *
```

To unpack an archive, use option `-x`:

```
tar -xf myTar.gz
```


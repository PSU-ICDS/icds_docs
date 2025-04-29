# File storage

Files are stored on Roar in a central filesystem.
Users have access to four directories:  home, work, scratch, and group.
These have different purposes:

- **home** – for configuration files, and links to work, group, and scratch.
- **work** – for your own work; 
only you have read-write access to your home and work directories.
- **scratch**  – for temporary storage of large files.  Scratch is *not backed up*, 
and files with a time stamp older than 30 days will be *automatically deleted*.
- **group** – for collaborative work. 
Group space can be purchased by PIs in 5 TB increments. 
By default, group members have read access to all files in group. 

Files in home, work, and group are backed up by a sequence of daily "snapshots", 
which are kept for 90 days. 
To have files restored from a snapshot, email Client Support at <icds@psu.edu>. 

!!! warning "No backup is infallible"
     Users are encouraged to back up critical data somewhere other than Roar.
     One option is the [Penn State University Backup Service][backup].
[backup]: https://pennstate.service-now.com/sp?id=it_service_offering_request_forms&offering_id=0d2d68fb37a75f406a0f94c543990eb8


## Quotas

home, work, group, and scratch directories are subject to limits,
both on the amount of storage space and on the number of inodes. 
Files, directories, and symlinks all count towards inode limits.

| Storage | Path | Size | Inodes | Backup | Purpose |
| :----: | :----: | :----: | :----: | :----: | :----: |
| Home | /storage/home | 16 GB | 500,000 | Daily  | Configuration files |
| Work | /storage/work | 128 GB | 1 million | Daily  | User data |
| Scratch | /scratch | None | 1 million | None | Temporary files |
| Group | /storage/group | Specific to<br>allocation | 1 million<br>per TB | Daily | Shared data |

## Checking usage

Exceeding quotas on home or work directories can cause errors 
when running progrms, writing files, or even logging in.

There are two tools to check on your disk usage:

- `check_storage_quotas` reports your total usage;
- [`du`][du] reports the sizes of files and directories.
[du]: https://man7.org/linux/man-pages/man1/du.1.html

`du -sh *` gives "human-readable" sizes (in MB, GB, TB) 
for each item in the current directory.

In managing storage, we often want to know where the big files are.
``
du -sh * | sort -h -r
``
lists directory sizes in order from large to small
(the output of du is "piped" to [sort][sort]).
[sort]: https://man7.org/linux/man-pages/man1/sort.1.html

## Quota issues in home

Many user configuration files and packages are stored by default in `home`.
If these become too large, they can exceed the quota and cause errors. 
This commonly occurs with directories such as

 - `.local` - used by Python
 - `.comsol` - used by Comsol

These [dot files](https://missing.csail.mit.edu/2019/dotfiles/) are hidden by default, 
but you can view them with `ls -la`.

If the size of one of these directories becomes a problem, 
it can be moved to `work`, and a link placed in your home directory.
To make such a link, in your home directory execute (e.g., for `.local`)
```
ln -s .local work/.local
```
This creates an alias (in Unix-speak, a "symbolic link") named `.local`,
which points to the directory you moved to `work`.

## Archive storage

To store infrequently-used files, low-cost archive storage can be purchased. 
The [Globus][globus] web interface is the only way to access these files, 
so access is neither quick nor convenient.
[globus]: transferring-files.md#globus

If you store a directory that contains many files, 
you should pack the directory into a single file with `tar`
(see [Packing files](managing-files.md#packing-files))
before transferring.

!!! warning "Do not use archive storage for sensitive data."
     If you need to archive data or software that must adhere to regulatory requirements
     please contact ICDS or the [Office of Information Security](https://security.psu.edu).



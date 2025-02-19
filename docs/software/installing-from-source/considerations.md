# Using Custom Software

## Installing from source

Roar Collab offers a broad range of installed open-source applications,
but sometimes you need an application that is not already available

Users are allowed and encouraged to compile and install their own software 
in their storage directories. Depending on how well documented the software 
is, installation may be straightforward or may require modification to the 
instructions to accomodate user permission levels.

## No root access

If you have worked with a laptop running Linux,
one important difference between installing software 
on your laptop and on Collab is **no root access**.
This means you cannot:

- use RPM package installers like [`yum`][yum]
- install executables in the standard places
[yum]: https://man7.org/linux/man-pages/man8/yum.8.html

For installations that require root or administrative access, please complete a 
[Software Request][SRF].

## Where to install

The question of where to install software depends heavily on who are the 
target users of the software. For items such as R or python 
packages or software only used by a single user, a user's home or work 
directory would be the best choice.

For software used by an entire research group, software can be placed in 
group storage directories. Care must be taken to ensure [File Permissions](../../handling-data/managing-files.md/#file-permissions) 
are set so the files are executable by the entire group.

If a software package would be used by more than a single research group, 
global installation is possible. To request this, please complete a [Software 
Request][SRF].

[SRF]: https://pennstate.service-now.com/sp?id=sc_cat_item&sys_id=e7332727dbd3e1105931aa1d13961993&sysparm_category=9f02239e0fd68b002c4900dce1050e8b

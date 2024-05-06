
---
title: Connecting
---


# Accounts


## Activating Your Account

All individuals who have an active Penn State access account (PSU ID) can request access to Roar Collab 
by submitting an [account request](https://www.icds.psu.edu/computing-services/account-setup). 


### Non-PSU Affiliates

For any external collaborators, a university faculty member must set up a [sponsored access account]
(https://security.psu.edu/services/penn-state-accts/sponsored) with the university Accounts Office to 
provide the collaborator with an access account. Once the collaborator access account is active, submit 
an [account request](https://www.icds.psu.edu/computing-services/account-setup) to RC.


## Connecting to Roar Collab

Users can connect to Roar Collab (RC) either through the RC Portal or via an `ssh` connection.


### Using the Roar Collab Portal

Users can connect to RC through the RC Portal powered by Open OnDemand. Open OnDemand is an NSF-funded, 
open-source HPC portal that provides users with a simple graphical web interface to HPC resources. Users 
can submit and monitor jobs, manage files, and run applications using just a web browser. The [RC Portal]
(https://rcportal.hpc.psu.edu) offers many familiar graphical development environments including JupyterLab,
RStudo, and software-specific GUIs.

The Portal features multiple built-in tools which can be accessed via the top menu bar on the Portal:

 - Apps: Lists all available Portal apps
 - Files: Provides a convenient graphical file manager and lists primary accessible file locations
 - Jobs: Lists active jobs and allows use of the Job Composer
 - Clusters: Provides shell access to submit nodes on RC
 - Interactive Apps: Provides access to all the Portal interactive apps and interactive servers
 - User Tools: Provides access to the User Filesystem Quotas display
 - My Interactive Sessions: Lists any active sessions


### Connecting via `ssh`

Those who prefer to utilize only the command line environment can connect using Secure Shell (SSH). 

Through the terminal on MacOS or Linux or Command Prompt on Windows, users can connect using the following
command:

```
$ ssh <userid>@submit.hpc.psu.edu
```
To connect, an RC account linked to an active Penn State access account user ID and password is required. By 
default, port 22 is used for secure shell connections.

A password must be entered and then multi-factor authentication must be completed successfully to complete the login.

> [!NOTE]
> The connection to the system is made with a submit node. Submit nodes are configured primarily to handle incoming 
> user connections and non-intensive computational tasks like editing small files. To perform computational tasks, 
> compute resources must be used. See [Submitting Jobs](03_SubmittingJobs.md) for more details.


[//]: <> (#### X11 Forwarding)




## Linux Commands Quick Reference

| Command | Description (For full documentation, use the command 'man command' to bring up the manual or find online documentation) |
| ls | The 'list' (ls) command is used to display all the files in your current directory. Using the '-a' flag will also show any hidden files (typically files beginning with a '.' like .bashrc) |
| cd | This is the 'change directory' command. Use this to traverse directories (like 'cd work'). To move back a directory level, use 'cd ..' |
| mv | The 'move' command takes two arguments, the first being the file to move and the second being the directory said file should be moved to ('mv file.txt /work/newdirectory/'). Note: 'mv' can also be used to rename a file if the second argument is simply a new file name instead of a directory |
| mkdir | This command is used to make directories |
| rmdir | This command is used to delete directories ('rm -rf directory' would also work) |
| touch | This command is used to create files in a similar way to mkdir. ('touch test.txt' will create an empty text file named test) |
| rm | This is the 'remove' command. As mentioned above, it can be used recursively to delete entire directory trees, or it can be used with no flags and a file as the argument to delete a single file |
locate | This command is used to locate files on a system. The flag '-i' will make the query case-insensitive, and asterisks ('*') will indicate wildcard characters |
| clear | Clears the terminal of all previous outputs leaving you with a clean prompt |
| history | Shows the previous commands entered |
| find | Used for finding files, typically with the -name flag and the name of the file |
| grep | Used for searching within files |
| awk | A programming language typically used for data extraction |
| id | Show all of the groups a user is in |
| du | Show the disk usage. Typically used with -h (for human readable) and –max-depth=1 to limit to only the directories in that level rather than all files |
| env | Print out all of the current environment variables |
| less | View a file |
| cp | Copy a file. Note the -r (recursive) flag can be used to copy directories |
| alias | Create an alias (something short) that is interpreted as something else (a complicated command) |
| pwd | Print the current working directory |
| chmod | Change file permissions |
| chgrp | Change group for a file or directory |
| ldd | Show the shared libraries required for an executable or library |
| top | See the node usage. Often used with command U |
| /usr/bin/time | Show time and memory statistics for a command being run. Often used with the -v (verbose) flag |
| bg | Continue running a paused task in the background |
| fg | Bring a background task into the foreground |
| Ctrl + c | Kill a process |
| Ctrl + z | Suspend a process |
| Ctrl + r | Search through your history for a command that includes the text typed next |


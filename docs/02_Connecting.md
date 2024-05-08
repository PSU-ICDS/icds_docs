
# Connecting




## Accounts


### Activating Your Account

All individuals who have an active Penn State access account (PSU ID) can 
request access to Roar Collab (RC) by submitting an 
[account request](https://www.icds.psu.edu/computing-services/account-setup). 


#### Non-PSU Affiliates

For any external collaborators, a university faculty member must set up a 
[sponsored access account](https://security.psu.edu/services/penn-state-accts/sponsored) 
with the university Accounts Office to provide the collaborator with an access 
account. Once the collaborator access account is active, submit an 
[account request](https://www.icds.psu.edu/computing-services/account-setup) 
to RC.


## Connecting to Roar Collab

Users can connect to RC either through the RC Portal or via an `ssh` 
connection.


### Using the Roar Collab Portal

Users can connect to RC through the RC Portal powered by Open OnDemand. Open 
OnDemand is an NSF-funded, open-source HPC portal that provides users with a 
simple graphical web interface to HPC resources. Users can submit and monitor 
jobs, manage files, and run applications using just a web browser. The 
[RC Portal](https://rcportal.hpc.psu.edu) 
offers many familiar graphical development environments including JupyterLab, 
RStudio, and software-specific GUIs.

The Portal features multiple built-in tools which can be accessed via the top 
menu bar on the Portal:

 - Apps: Lists all available Portal apps
 - Files: Provides a convenient graphical file manager and lists primary accessible file locations
 - Jobs: Lists active jobs and allows use of the Job Composer
 - Clusters: Provides shell access to submit nodes on RC
 - Interactive Apps: Provides access to all the Portal interactive apps and interactive servers
 - User Tools: Provides access to the User Filesystem Quotas display
 - My Interactive Sessions: Lists any active sessions


### Connecting via `ssh`

Those who prefer to utilize only the command line environment can connect using 
Secure Shell (SSH). 

Through the terminal on MacOS or Linux or Command Prompt on Windows, users can 
connect using the following command:

```
$ ssh <userid>@submit.hpc.psu.edu
```
To connect, an RC account linked to an active Penn State access account user ID 
and password is required. By default, port 22 is used for secure shell 
connections.

A password must be entered and then multi-factor authentication must be 
completed successfully to complete the login.

.. note::
    The connection to the system is made with a submit node. Submit nodes are  
    configured primarily to handle incoming user connections and non-intensive 
    computational tasks like editing small files. To perform computational 
    tasks, compute resources must be used. See 
    [Submitting Jobs](03_SubmittingJobs.md) for more details.


[//]: <> (#### X11 Forwarding)




## Linux Commands Quick Reference

| Command | Description |
| ls | Lists the files in the current working directory |
| cd | Changes the current directory in order to navigate to a new directory |
| mv | Moves a file or directory to a new location |
| mkdir | Makes a directory |
| rmdir | Removes an empty directory |
| touch | Creates a file |
| rm | Removes a file (or a directory using the `-r` option) |
| locate | Locates a file in a directory |
| clear | Clears the terminal of all previous outputs |
| history | Shows the history of previous commands |
| find | Finds files in a directory |
| grep | Searches files or outputs |
| awk | A programming language for pattern scanning and processing |
| id | Shows the list of groups for a user |
| du | Shows disk usage |
| env | Prints the current environment variables |
| less | Displays a file |
| cp | Copies a file (or a directory using the `-r` option) |
| alias | Creates an alias, which is essentially an abbreviated command |
| pwd | Prints the current working directory |
| chmod | Changes file permissions |
| chgrp | Changes group for a file or directory |
| ldd | Shows the shared libraries required for an executable or library |
| top | Displays the node usage |
| /usr/bin/time | Shows time and memory statistics for a command being run |
| bg | Continues running a paused task in the background |
| fg | Brings a background task into the foreground |
| Ctrl + c | Kills a process |
| Ctrl + z | Suspends a process |
| Ctrl + r | Searches the command history for a string |

For complete details on any command listed above and more, use `man <command>` 
in a terminal session to display the manual page for the command or search 
online for more detailed usage of fundamental Linux commands.


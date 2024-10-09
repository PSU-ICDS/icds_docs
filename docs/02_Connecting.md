
# Connecting



## Accounts



### PSU Affiliates

All individuals with an active Penn State access account and a Penn State email address may request access to Roar by submitting an [account request](https://www.icds.psu.edu/computing-services/account-setup). 
A Principal Investigator (PI) must be specified to request an account. 
The PI must be Penn State faculty and should be a supervisor, advisor or collaborator.
Roar Collab (RC) accounts are granted to any users upon PI approval, but Roar Restricted (RR) accounts are only granted to individuals that require access to an active restricted storage allocation. For additional information on RR account activation, see the [Roar Restricted Addendum](06_RoarRestricted.md).


### Non-PSU Affiliates

For any external collaborators, a university faculty member must set up a 
[sponsored access account](https://security.psu.edu/services/penn-state-accts/sponsored) with the university Accounts Office to provide the collaborator with an access account and a Penn State email address. 
Once the collaborator's access account is active, submit an [account request](https://www.icds.psu.edu/computing-services/account-setup).


## Connecting to Roar

Users can connect to RC either through the [RC Portal](https://rcportal.hpc.psu.edu) ([rcportal.hpc.psu.edu](https://rcportal.hpc.psu.edu)) or via an `ssh` connection to the `submit.hpc.psu.edu` host.

Users can only connect to RR via the [RR Portal](https://rrportal.hpc.psu.edu) ([rrportal.hpc.psu.edu](https://rrportal.hpc.psu.edu)), and RR is only accessible when connecting either via the Penn State network or via the Penn State GlobalProtect VPN. 
For additional information on connecting to RR, see the [Roar Restricted Addendum](06_RoarRestricted.md).


### Roar Portals

Users can connect to Roar through the Roar Portals powered by Open OnDemand. 
Open OnDemand is an NSF-funded, open-source HPC portal that provides users with a simple graphical web interface to HPC resources. 
Users can submit and monitor jobs, manage files, and run applications using just a web browser.
The Roar Portals feature multiple built-in tools which can be accessed via the top menu bar on the Portals:

 - Apps: Lists all available Portal apps
 - Files: Provides a convenient graphical file manager and lists primary accessible file locations
 - Jobs: Lists active jobs and allows use of the Job Composer
 - Clusters: Provides shell access to submit nodes on RC
 - Interactive Apps: Provides access to all the Portal interactive apps and interactive servers
 - User Tools: Provides access to the User Filesystem Quotas display
 - My Interactive Sessions: Lists any active sessions


!!! warning  "File Manager tool is disabled on RR Portal."

    In accordance with RR's Secure Data Transfer Management Model, the File Manager tool on the RR Portal is disabled. For additional information on the file transfer process for RR, see the [Roar Restricted Addendum](06_RoarRestricted.md).


### Connecting via `ssh`

Those who prefer to utilize only the command line environment can connect to RC using Secure Shell (SSH). 
SSH access for RR is disabled in accordance with security requirements for handling restricted data.

Through the terminal on macOS or Linux or the command prompt on Windows, users can connect to RC using the following command:

```
$ ssh <userid>@submit.hpc.psu.edu
```

To connect, an RC account linked to an active Penn State access account user ID and password is required. 
By default, port 22 is used for secure shell connections. 
A password must be entered and then multi-factor authentication must be completed successfully to complete the login.

!!! error  "Do Not Perform Computationally Intensive Tasks On Submit Nodes"

    The connection to the system is made with a submit node. Submit nodes are configured primarily to handle incoming user connections and non-intensive computational tasks like editing small files. To perform computational tasks, compute resources must be used. See [Submitting Jobs](03_SubmittingJobs.md) for more details.


[//]: <> (#### X11 Forwarding)




## Linux Commands Quick Reference

| Command | Description |
| ---- | ---- |
| `ls` | Lists the files in the current working directory |
| `cd` | Changes the current directory to navigate to a new directory |
| `mv` | Moves a file or directory to a new location |
| `mkdir` | Makes a directory |
| `rmdir` | Removes an empty directory |
| `touch` | Creates a file |
| `rm` | Removes a file (or a directory using the `-r` option) |
| `locate` | Locates a file in a directory |
| `clear` | Clears the terminal of all previous outputs |
| `history` | Shows the history of previous commands |
| `find` | Finds files in a directory |
| `grep` | Searches files or outputs |
| `awk` | A programming language for pattern scanning and processing |
| `id` | Shows the list of groups for a user |
| `du` | Shows disk usage |
| `env` | Prints the current environment variables |
| `less` | Displays a file |
| `cp` | Copies a file (or a directory using the `-r` option) |
| `alias` | Creates an alias, which is essentially an abbreviated command |
| `pwd` | Prints the current working directory |
| `chmod` | Changes file permissions |
| `chgrp` | Changes group for a file or directory |
| `ldd` | Shows the shared libraries required for an executable or library |
| `top` | Displays the node usage |
| `/usr/bin/time` | Shows time and memory statistics for a command being run |
| `bg` | Continues running a paused task in the background |
| `fg` | Brings a background task into the foreground |
| `Ctrl + c` | Kills a process |
| `Ctrl + z` | Suspends a process |
| `Ctrl + r` | Searches the command history for a string |

Special characters are useful in many commands.

| Character | Description |
| :----: | ---- |
| `~` | Indicates the home directory |
| `.` | Indicates current working directory |
| `..` | Indicates parent of current working directory |
| `*` | Wildcard character for any string |
| <code>&#124;</code> | Connects the output of a command to the input of another |
| `>` | Redirects a command output |

For complete details on any command listed above and more, use `man <command>` in a terminal session to display the manual page for the command or search online for more detailed usage of fundamental Linux commands.


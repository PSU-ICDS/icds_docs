
---
title: Connecting to Roar
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


#### X11 Forwarding




## Linux Commands Quick Reference




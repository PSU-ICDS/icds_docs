
---
title: Connecting
---

# Connecting

Users can connect to Roar Collab (RC) either through the RC Portal or via an `ssh` connection.


## Using the Roar Collab Portal

Users can connect to RC through the RC Portal powered by Open OnDemand. Open OnDemand is an NSF-fund, open-source HPC portal that provides users with a simple graphical web interface to HPC resources. Users can submit and monitor jobs, manage files, and run applications using just a web browser. The [RC Portal](https://rcportal.hpc.psu.edu) offers a graphical interface to RC and may be preferable for users that are not comfortable in a command line environment.

The Portal features multiple built-in tools that are both convenient and intuitive to use. The top menu bar on the Portal has the following options:

 - Apps: Lists all available Portal apps
 - Files: Provides a convenient graphical file manager and lists primary accessible file locations
 - Jobs: Lists active jobs and allows use of the Job Composer
 - Clusters: Provides shell access to submit nodes on RC
 - Interactive Apps: Provides access to all the Portal interactive apps and interactive servers
 - User Tools: Provides access to the User Filesystem Quotas display
 - My Interactive Sessions: Lists any active sessions


## Connecting via `ssh`

The most straightforward way to connect to RC is with a secure shell client via the `ssh` command. On MacOS or Linux devices, the default terminal application has an `ssh` command available by default. On Windows devices, a secure shell client, like [PuTTy](https://www.putty.org/), must be downloaded and installed.

The host address for RC is **submit.hpc.psu.edu**. To connect, an RC account linked to an active Penn State access account user ID and password is required. By default, port 22 is used for secure shell connections.

From a terminal session, a connection can be made with RC using
```
$ ssh <userid>@submit.hpc.psu.edu
```

A password must be entered and then multi-factor authentication must be completed successfully to complete the login.

> [!NOTE]
> The connection to the system is made with a submit node. Submit nodes are configured primarily to handle incoming user connections and non-intensive computational tasks like editing small files. To perform computational tasks, compute resources must be used. See [Submitting Jobs](04_SubmittingJobs.md) for more details.


### X11 Forwarding




## Linux Commands Quick Reference




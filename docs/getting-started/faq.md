# Frequently Asked Questions

This section covers some of the most common errors and questions that arise when working with on Roar Collab.


## Why is my job not starting?

If your job's status (`ST`) in the `squeue` command is `PD` (Pending), it is waiting for 
resources to become available. You can see the specific reason in the `NODELIST(REASON)` 
column of the `squeue` output.

For details on checking the status of your jobs on the portal, please see our video on 
[Debugging Portal Job Issues](https://psu.mediaspace.kaltura.com/media/Tuesday+Tips+October/1_ph23usu3).

Common reasons include:

- **(Resources):** This is the most common reason. It simply means the cluster is busy 
and all nodes that can fulfill your request (for memory, cores, GPUs, etc.) are currently 
in use by other jobs. The only solution is to wait for resources to free up.

- **(Priority):** Your job is waiting its turn behind other jobs that have a higher 
priority. Your job's priority will increase over time, so the solution is to wait.

- **(QOSMax---PerUserLimit):** You have reached the maximum number of cores, nodes, 
memory or jobs you are allowed to run simultaneously in a specific Quality of Service 
(QoS). You must wait for some of your other jobs to finish before this one can start.

- **(AssocGrpBillingMinutes):** Your credit account does not have sufficient balance to 
run this job. If running jobs complete sooner than expected, your job may launch if there 
are sufficient credits remaining. Otherwise, please [contact us](getting-help.md) to 
purchase additional credits.

- **(ReqNodeNotAvail):** There is no available hardware that matches your resource request. 
Either the resource configuration does not exist, or the only matching nodes are down.

- **(Reserved for maintenace):** Your job is not expected to complete prior to a 
scheduled outage and has been held until after the outage is over.

##  Why did my job fail with an "Out of Memory" error?

This typically means your job tried to use more memory (RAM) than you allocated with the 
`--mem` or `--mem-per-cpu` directive. Slurm terminates the job to protect the node and 
other users' jobs.

**Solution:**

**Check actual usage:** Find the peak memory your failed job used with the `sacct` command. 
The `MaxRSS` field shows this value.

```bash
sacct -j YOUR_JOB_ID --format=MaxRSS,ReqMem
```

**Resubmit with more memory:** Edit your batch script to request more memory than the 
`MaxRSS` value. It's a good practice to add a 10-20% buffer.


## Why did I get a "Permission Denied" error?

This error means you are trying to read, write, or execute a file or directory that your 
user account does not have the rights to access.

**Common Causes & Solutions:**

- **You are trying to run a script that is not executable.** By default, new files 
do not have "execute" permission.
    - **Solution:** Add execute permission with the `chmod` command: `chmod +x your_script.sh`.

- **You are trying to write to a protected directory.** You only have permission to write 
nside your personal storage spaces.
    - **Solution:** Make sure your script is only writing to your `$HOME`, `$WORK`, or 
    `$SCRATCH` directories.

- **You are trying to access storage for a group you are not a part of.** By default, 
users are not added to any groups.
    - **Solution:** If you are trying access group storage, you may need to talk to your 
    PI/owner of the storage and request access.
 

## Quota issues in home

Many user configuration files and packages are stored by default in `home`.
If these become too large, they can exceed the quota and cause errors. 
This commonly occurs with directories such as

 - `.conda` - used by Anaconda
 - `.comsol` - used by Comsol
 - `.local` - used by Python

These [dot files](https://missing.csail.mit.edu/2019/dotfiles/) (and directories) 
are hidden by default, but you can view them with `ls -la`.

If the size of one of these directories becomes a problem, 
it can be moved to `work`, and a [symbolic link] created 
which points to the directory you moved to `work`.

For example, the commands needed to move the `.local` directory 
would look like:

```
# first move the directory to /storage/work/
mv ~/.local $WORK/.local

# create a symlink in home pointing to the new location in work
ln -s $WORK/.local .local
```

[symbolic link]:https://www.lenovo.com/us/en/glossary/symbolic-link/


## Job fails after hours or days. How can I help support reproduce the issue?

Provide a minimal, fast, reproducible example by reducing:

- Input size (smaller dataset/grid/iteration count)
- Runtime (seconds or minutes instead of hours)
- Resources (fewer cores/nodes)


Often the underlying issue appears when the problem is minimized. Even if it does not, 
the smaller example allows support to reproduce and fix the issue much more quickly.

For further help, contact [ICDS help desk](getting-help.md) 

## I can't login to the portal

This can be caused by a few different reasons.

**You don't have an active account on our systems**

If you have not logged into the portal before, you will need to [request a login account](connecting.md/#roar-account-creation) 
before you can access Roar Collab. To verify that your account request went through 
successfully, you should receive a confirmation email once you submit the form and another 
email once the account is created.

**Your home directory is over quota**

The portal writes session and job files to your home directory. If your home directory is 
over quota, this may prevent logging in. Please use [Globus](http://www.globus.org) to 
move or delete files in your home directory to free up space. For more information on how 
to use Globus, please see our [Globus documentation](../file-system/transferring-files.md#globus).

Many times, file usage in home may be inside hidden directories. Please see 
[Quota issues in home](#quota-issues-in-home) for more information 
on how to handle these issues.

**Your portal session files have become corrupted**

This issue should self correct, however you can manually reset your portal session by 
using this link:

[Portal session reset link](https://portal.hpc.psu.edu/nginx/stop?redir=/pun/sys/dashboard/){ .md-button }

**Local browser issues**

There may be an issue with your local session files. Try using a different browser, 
an incognito or private viewing window, or clearing your cache including login sessions.

If you are stil encountering issues after trying the above, please [contact us](mailto:icds@psu.edu) for more assistance.

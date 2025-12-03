## FAQ

This section covers some of the most common errors and questions that arise when working with on Roar Collab.



### Why is my job stuck in the queue?

If your job's status (`ST`) in the `squeue` command is `PD` (Pending), it is waiting for resources to become available. You can see the specific reason in the `NODELIST(REASON)` column of the `squeue` output.

Common reasons include:

- **(Resources):** This is the most common reason. It simply means the cluster is busy and all nodes that can fulfill your request (for memory, cores, GPUs, etc.) are currently in use by other jobs. The only solution is to wait for resources to free up.

- **(Priority):** Your job is waiting its turn behind other jobs that have a higher priority. Your job's priority will increase over time, so the solution is to wait.

- **(QOSMax---PerUserLimit):** You have reached the maximum number of cores, nodes, memory or jobs you are allowed to run simultaneously in a specific Quality of Service (QoS). You must wait for some of your other jobs to finish before this one can start.

- **(AssocJobLimit):** Your account or allocation has reached the maximum number of running jobs it is allowed.

---

###  Why did my job fail with an "Out of Memory" error?

This typically means your job tried to use more memory (RAM) than you allocated with the `--mem` or `--mem-per-cpu` directive. Slurm terminates the job to protect the node and other users' jobs.

**Solution:**

**Check actual usage:** Find the peak memory your failed job used with the `sacct` command. The `MaxRSS` field shows this value.
    ```bash
    sacct -j YOUR_JOB_ID --format=MaxRSS,ReqMem
    ```

**Resubmit with more memory:** Edit your batch script to request more memory than the `MaxRSS` value. It's a good practice to add a 10-20% buffer.

---

### Why did I get a "Permission Denied" error?

This error means you are trying to read, write, or execute a file or directory that your user account does not have the rights to access.

**Common Causes & Solutions:**

- **You are trying to run a script that is not executable.** By default, new files do not have "execute" permission.
    - **Solution:** Add execute permission with the `chmod` command: `chmod +x your_script.sh`.

- **You are trying to write to a protected directory.** You only have permission to write inside your personal storage spaces.
    - **Solution:** Make sure your script is only writing to your `$HOME`, `$WORK`, or `$SCRATCH` directories.

- **You are trying to access storage for a group you are not a part of.** By default, users are not added to any groups.
    - **Solution:** If you are trying access group storage, you may need to talk to your PI/owner of the storage and request access.
 

---

### Quota issues in home

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

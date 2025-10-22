# Tips for beginners

!!! warning "Don't use submit nodes for heavy computing."
     Submit nodes are for preparing files, submitting jobs, 
     examining results, and transferring files.

!!! warning "Don't store files on scratch."
     [Scratch is not backed up](../file-system/file-storage.md/#quotas), 
     and files older than 30 days old are deleted.

!!! warning "Don't overrun your file storage quota."
     If you fill your allotted disk space, weird errors occur.
     Keep an eye on your [disk space usage](../file-system/file-storage.md/#quotas).

!!! warning "Don't waste your compute resources."
     Use interactive sessions to test your workflow.
     Before a big batch job, run test jobs to make sure your code works.

!!! warning "Capture job output and error logs"
    To debug failed or unexpected jobs, it can be helpful to capture output and error streams
    separately. To do so, add these lines to the slurm job script:
    #SBATCH --output=job_%j.out
    #SBATCH --error=job_%j.err
    
!!! warning "Using modules"
     Most software on Roar is managed through the software stack and loaded
     using modules. Please check [Modules](../software/modules.md)

## Roar uses Linux

The operating system for Roar is Red Hat Enterprise Linux 8 ([RHEL8][rhel8]),
a variant of Unix.
Linux is text-based; users interact with the system by typing commands.
Compute clusters use Linux in part because tasks can be automated with scripts.
[rhel8]: https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9

This user guide assumes familiarity with Linux,
which any user who wants to do more than use the Portal needs to learn.
A tutorial website for Unix can be found [here][unix_tutorial].
[unix_tutorial]: https://www.tutorialspoint.com/unix/unix_tutorial.pdf
The first chapter of [this book][unixphysics] is also helpful.
An introduction to Unix
written for research undergraduates and graduate students,
is [here](../pdf/unixGuide.pdf).
[unixphysics]: https://www.oreilly.com/library/view/effective-computation-in/9781491901564/?sso_link=yes&sso_link_from=pennsylvania-state-university

See also the online lesson [HPC Carpentry lesson "Introduction
to Using the Shell in a HPC Context"](https://www.hpc-carpentry.org/hpc-shell/),
which can be followed after [logging onto Roar](connecting.md/#ssh).


# How to Write a Good Support Ticket

If you cannot resolve an issue after checking the documentation and a quick web search, we are happy to help. To get you help faster, please follow the guidelines below.

> Send requests to **icds@psu.edu** (do not email individual staff).  
> New problem → new email/thread.

---

## Before You Write
1. **Search the [ICDS documentation](https://docs.icds.psu.edu/).**  
2. **Search the web** using the exact error text and tool name.  
3. If the job/problem is large, **try to reproduce with a smaller/sample example** first.

---

## What to Include in the ticket (Minimum)
- **Descriptive subject line.** Example: `sbatch: error: Batch job submission failed: Invalid account or account/partition combination specified` OR `SLURM: sbatch fails with "permission denied" on login02`
- **What you are trying to achieve.**  
- **When it started** and **whether it worked before**.  
- **What you already tried** (and what *did* work).  
- **Exact commands** you ran and **full error/output** (copy/paste text; **no screenshots**).  
- **Your PSU ID (abc123 from abc123@psu.edu)** and **which system/service** you’re using.  
- **Environment details** (modules, compilers, Python/conda environment).  
- If complex: a **small, fast, reproducible example**.
- If it's any **software**, please provide a **brief description** of the software and its purpose.

> **Never include** passwords or sensitive/regulated data in tickets or emails.

---

## Do / Don’t (condensed from community HPC guidance)
- **Do** email the help address (team queue), **don’t** email individuals directly.  
- **Do** provide actual commands and complete error text (copy/paste), **also** attach error screenshots.  
- **Do** start a **new email** for a new problem, **don’t** reply to unrelated threads.  
- **Do** state the real goal (avoid the **XY problem**); if you tried *Y* to achieve *X*, also tell us *X*.  
- **Do** tell us what already works and what tests you ran.  
- **Do** specify your environment (loaded modules, compilers, interpreter).  
- **Do** minimize the example so we can reproduce quickly.

---

## Ready-to-Copy Ticket Template

Hello ICDS Client Support,

Goal:
	•	<What you are trying to do (X)>

Context:
	•	First seen: <date/time>
	•	Worked before?: <Yes/No/Unknown>
	•	System/service: <cluster/login node/portal/storage path/etc.>
	•	Username: <your_PSU_ID>

What I tried:
     •	<steps or variants you attempted>
     •	<what DID work, if anything>

Commands and output (text, also screenshots to understand the interface):
	•	Command(s):
<copy/paste exact commands>
	•	Output/error:
<copy/paste full output and error text>

Environment:
	•	Modules: <output of module list if applicable>
	•	Compiler/Interpreter: <e.g., gcc --version, python --version>
	•	Conda/venv (if used): <name + how created> (optional)

Repro (if complex):
	•	How to reproduce quickly:
<minimal inputs, small dataset, expected/actual result>

Thanks,

---

## Common Cases: What We Need

### A) Problems Connecting via SSH
Please include:
- **Client machine/IP** you connect from  
  - Linux/macOS/Windows and name of the terminal using, for example system inbuilt terminal or other terminal applications.  
- **Did this ever work before?**  
- **Your PSU ID**
- **Error you're encountering on the terminal**  
- **SSH details**  
  - Output of `ssh-add -l` (if using keys/agent)  
  - Run the failing command with verbose flags and include text output:  
    ```
    ssh -vvv <your_psu_id>@submit.hpc.psu.edu
    ```
    If you're trying to ssl to the requested node
    ```
    ssh -vvv <your_psu_id>@<node>
    ```
- **Server response** (any banner/message shown)

### B) Problems Submitting or Running SLURM Jobs
Please include:
- **Working directory path** where you run the job  
- **Submission script** content (entire `sbatch` script)  
- **Exact submission command** you used (e.g., `sbatch job.slurm`)  
- **Job ID** returned by SLURM  
- **SLURM diagnostics** (copy/paste text):
Command:
     •	$ sacct -j <JobID> --format=User%8,Account%10,JobID%10,state%10,time%10,elapsed%10,nnodes%3,NTasks%3,ncpus%3,nodelist%40,Reqmem%6,AllocTRES%36,Reason%30 
- **When it started/failed/cancelled** and **whether the script worked before**.
- If the job produced stderr/stdout files, include those text snippets as well.

---

## Minimal, Fast, Reproducible Examples (for complex issues)
If your job crashes after a few hours/days, please try to reproduce with:
- Smaller input (reduced size/grid/iterations)  
- Short runtime (seconds/minutes)  
- Fewer nodes/cores

Often the root cause appears while minimizing. If not, your smaller example lets us reproduce and fix quickly.

---

## Attribution
This page is adapted from established HPC guidance:
- “How to write good support requests” (hpc-wiki.info)  
- Source text from HPC-UIT documentation (hpc-uit.readthedocs.io)  
- “How-To: Write a Good Ticket” and diagram (CUBI HPC docs)
Since Roar uses RHEL, it sets the following variables for you - 

- $USER is your Penn State User ID. 
- $HOME points to your home directory (/storage/home/$USER).
- $WORK points to your work directory (/storage/work/$USER).
- $SCRATCH points to your scratch directory (/storage/scratch/$USER).

## Common Issues and Solutions

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
 

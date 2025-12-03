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
    `#SBATCH --output=job_%j.out`
    `#SBATCH --error=job_%j.err`
    
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

---

## Contacting ICDS Support

If you need help using Roar (RC or RR), please submit your support request **one of the following ways**:

- **Email**: <icds@psu.edu>
- **Service Portal**: [Submit a ticket via ServiceNow](https://pennstate.service-now.com/sp?id=sc_cat_item&sys_id=dd1c98f11b57e510bd31ed74bd4bcb1a)
- **Support Ticket** : Submit through the Roar portal

Our team of HPC experts will respond as quickly as possible.

## Before You Write
1. **Search the [ICDS documentation](https://docs.icds.psu.edu/).**  
2. **Search the web** using the exact error text and tool name.  
3. If the job/problem is large, **try to reproduce with a smaller/sample example** first.

## What to Include in the ticket (Minimum)
- **Descriptive subject line.** Example: `sbatch: error: Batch job submission failed: Invalid account or account/partition combination specified` OR `Slurm: sbatch fails with "permission denied" on login02`
- **What you are trying to achieve.**  
- **When it started** and **whether it worked before**.  
- **What you already tried** (and what *did* work).  
- **Exact commands** you ran and **full error/output** (copy/paste text; **no screenshots**).  
- **Your PSU ID (abc123 from abc123@psu.edu)** and **which system/service** you’re using.  
- **Environment details** (modules, compilers, Python/conda environment).  
- If complex: a **small, fast, reproducible example**.
- If it's any **software**, please provide a **brief description** of the software and its purpose.

!!! warning "Never include" 
    Passwords or sensitive/regulated data in tickets or emails.

## Do / Don’t
- **Do** email the help address (team queue), **Avoid** email individuals directly.  
- **Do** provide actual commands and complete error text (copy/paste), **also** attach error screenshots.  
- **Do** start a **new email** for a new problem, **Don’t** reply to unrelated threads.  
- **Do** state the real goal (avoid the **XY problem**); if you tried *Y* to achieve *X*, also tell us *X*.  
- **Do** tell us what already works and what tests you ran.  
- **Do** specify your environment (loaded modules, compilers, interpreter).  
- **Do** minimize the example so we can reproduce quickly.


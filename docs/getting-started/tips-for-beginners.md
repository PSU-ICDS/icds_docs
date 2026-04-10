# Tips for beginners

!!! note "Don't use submit nodes for heavy computing."
     Submit nodes are for preparing files, submitting jobs, 
     examining results, and transferring files.

!!! note "Avoid storing important files in scratch."
     [Scratch is not backed up](../file-system/file-storage.md/#quotas), 
     and files older than 30 days old are deleted.

!!! note "Monitor your storage quota."
     If you fill your allotted disk space, weird errors occur.
     Keep an eye on your [disk space usage](../file-system/file-storage.md/#quotas).

!!! note "Use compute resources responsibly."
    Always run small test jobs first, to make sure your big job will work. 
    Use [`job_estimate`](../running-jobs/batch-jobs.md/#estimating-resource-usage) 
    to estimate the cost of your job in credits before you run it.

!!! note "Capture job output and error logs."
    To debug failed batch jobs, it helps to separate output and error streams, 
    by adding these lines to the job script:
    `#SBATCH --output=job_%j.out`
    `#SBATCH --error=job_%j.err`
    
## Roar uses Linux

The operating system for Roar is Red Hat Enterprise Linux 8 
([RHEL8](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8))
a variant of Unix. Linux is text-based; users interact with the system by typing commands.
Compute clusters use Linux in part because tasks can be automated with scripts.

This user guide assumes familiarity with Linux, which any user who wants to 
do more than use the Portal needs to learn.

To learn more about Linux, we recommend the following resources:

 - [Unix tutorial](https://www.tutorialspoint.com/unix/unix_tutorial.pdf)
 - [Effective Computation in Physics - Chapter One](https://www.oreilly.com/library/view/effective-computation-in/9781491901564/?sso_link=yes&sso_link_from=pennsylvania-state-university)
 - [Introduction to Using the Shell in an HPC Context by HPC Carpentry](https://www.hpc-carpentry.org/hpc-shell/) which can be followed after [logging onto Roar](connecting.md/#two-ways-to-access) and [accessing the command line](../running-jobs/portal.md#command-line-access).


## Glossary

Understanding these concepts will help you use the system and communicate with support.

### Batch job
A [batch job](../running-jobs/batch-jobs.md)
is a compute job submitted for execution without user intervention.
Batch jobs are defined in scripts that specify commands, resources, and output files.
The [SLURM scheduler](../running-jobs/slurm-scheduler.md)
allocates resources and schedules the job to run.
Batch jobs are ideal for long-running or resource-intensive computations.

### Cluster and nodes
A cluster is a set of interconnected compute nodes that work together.
A node is a single computer in the cluster, usually with two CPUs.
Multiple jobs can run at the same time on a single node.

### CPUs and cores
A CPU (central processing unit) contains multiple cores,
typically 32 or 64 cores per CPU.
Each core can run independent tasks.
Multiple cores can perform tasks in parallel, 
if your application supports parallel execution.

### Directory
A directory is a folder in the filesystem, in which files are stored.
On Roar, key directories include home, work, group and scratch.
See [File Storage](../file-system/file-storage.md) for details.

### Environment variables
Environment variables store file paths and software settings
used by programs and scripts.
For example:

- $USER is your Penn State User ID. 
- $HOME points to your home directory (/storage/home/$USER).
- $WORK points to your work directory (/storage/work/$USER).
- $SCRATCH points to your scratch directory (/storage/scratch/$USER).
- $PATH is the set of places the system looks for executable files.

To view all your environment variables, use `printenv`.

### GPU
A Graphics Processing Unit (GPU) is a specialized processor for parallel computation.
which speeds execution of programs written to use GPUs.
Some but not all nodes have GPUs.
Roar offers several GPU types:

- **A100**, **A40** — high-end, expensive
- **V100**, **P100** — mid-range, cost-effective

See [Compute hardware](../system/compute-hardware.md)
for more about GPUs, and 
[Hardware requests](../running-jobs/resource-requests.md) 
for how to request them.

### Modules
[Modules](../software/modules.md) 
provide a system for managing software environments;
users can load and unload different versions of software packages.

### Partition
A [partition](../system/system-overview.md#partitions)
is a group of nodes with similar hardware, access policies, and billing rates. 
Users specify partitions when launching Portal sessions, 
interactive jobs, or batch jobs.

### Parallel processing
In parallel processing, a task is divided 
across multiple CPU cores or GPUs to speed execution.
Parallel processing is used in simulations, image processing, 
machine learning, and data analytics.

In serial processing, a task runs on only one core.
Unless explicitly written and compiled for parallel processing,
all programs and scripts are serial. 


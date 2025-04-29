
# Batch jobs

For compute jobs that take hours or days to run,
instead of sitting at the terminal waiting for the results,
we submit a "batch job" to the queue manager,
which runs the job when resources are available.

## Slurm commands

On Roar, the queue manager is SLURM (Simple Linux Utility for Resource Management).  
Besides `salloc` for [interactive jobs](interactive-jobs.md)),
the basic SLURM commands are:

| Command | Effect|
| ---- | ---- | 
| `sbatch <script>` | submit batch job `<script>` | 
| `squeue -u <userid>` | check on jobs submitted by `<userid>` |
| `scancel <jobID>` | cancel the job | 

When you execute `sbatch myJob.sh`, SLURM responds with something like
```
Submitted batch job 25789352
```
To check on your jobs, execute `squeue -u <userID>`; SLURM responds with something like
```
JOBID		PARTITION	NAME		USER	ST	TIME	NODES	NODELIST(REASON)
25789352	open 		myJob.sh	abc123	R	1:18:31	1		p-sc-2008
```
Here ST = status:  PD = pending, R = running, C = completed.  
To cancel the job, execute `scancel 25789352`.

## Batch scripts

Jobs submitted to SLURM are in the form of a "batch script". 
A batch script is a shell script that executes commands, 
with a preamble of Slurm [resource directives](slurm-scheduler.md/#resource-directives) 
`#SBATCH...` to specify

- an **account** or **allocation** to charge;
- a **queue** (qos) to submit the job to;
- a **partition** (type of nodes) to run on;
- nodes, cores, memory, GPUs, and time;
- and other job-related parameters.

An example is:

```
#!/bin/bash
#SBATCH --account=...
#SBATCH --qos=normal
#SBATCH --partition=basic
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=1gb
#SBATCH --time=4:00:00
#SBATCH --job-name=...

# as usual, cd to the submit directory
cd $SLURM_SUBMIT_DIR

# load the needed module
module load gromacs-2019.6

SYSTEM=$SLURM_SUBMIT_DIR/System
gmx grompp -f $SYSTEM/nvt.mdp -c $SYSTEM/min.gro -p $SYSTEM/testJob.top -o nvt.tpr 
gmx mdrun -nt 8 -nb cpu -deffnm nvt
```

The first line `#!/bin/bash` is the "shebang", which says the script 
should be run under `bash` (a Linux shell).
Everything after the last `#SBATCH` are commands to be executed;
lines with `#` other than `#SBATCH` are ordinary bash script comments.
Most scripts start with `cd $SLURM_SUBMIT_DIR`,
which is the directory from which the job was submitted.

For more information on partitions, see [Partitions][partitions].  
For more information on hardware requests, see [Hardware requests][hardware].
[partitions]: ../getting-started/compute-hardware.md#partitions
[hardware]: hardware-requests.md

For a repository of example batch workflows, go [here][repository].
[repository]: https://github.com/PSU-ICDS/rc-example-jobs

!!!warning "To use the open queue, use --partition=open"
	Unpaid jobs under the open queue cannot specify a hardware partition,
	but will be assigned to available older CPU hardware.

!!!warning "To use a paid allocation, use --partition=sla-prio"
	Jobs under a paid allocation do not specify the basic, standard,
	high-memory, or interactive partitions.
	Instead, --partition=sla-prio tells the job
	to use the hardware in your allocation.

## Queues

The directive `#SBATCH --qos=<queue>` submits batch jobs to a queue, 
or QoS = "Quality of Service" in SLURM-speak.
(Queues are like classes of service on an airline flight:
first, business, economy,...)

Roar has five queues:  open, normal, debug, express, and interactive.  
Each serves a different purpose, and has different restrictions.

| queue (QOS) | description | restrictions |
| ---- | ---- | ---- |
| open | no-cost access | Portal and old hardware only, <br> pre-emptible, time < 2 days |
| normal | for "normal" jobs | time < 14 days |
| debug	| for testing, debugging, <br> quick analysis | one at a time, time < 4 hours |
| express | for rush jobs; <br> 2x price | time < 14 days |
| interactive | for Portal jobs | time < 7 days |

To get detailed information about queues, use `sacctmgr list qos`.  
This command has a lot of [options](https://slurm.schedmd.com/sacctmgr.html),
and works best with formatting:  an example is
```
sacctmgr list qos format=name%8,maxjobs%8,maxsubmitjobsperuser%9,maxwall%8,\
priority%8,preempt%8,usagefactor%12 names=open,ic,debug,express,normal
```
which produces output like this:
```
    Name  MaxJobs MaxSubmit  MaxWall Priority  Preempt  UsageFactor
-------- -------- --------- -------- -------- -------- ------------
  normal                                 1000     open     1.000000
    open      100       200                 0              1.000000
      ic        1                           0              1.000000
   debug        1         1 04:00:00    20000     open     1.000000
 express                                10000     open     2.000000
```

## Resource usage

For credit accounts, it is helpful to estimate how many credits a batch job would use
before you actually run it. For this, use `job_estimate`:

```
job_estimate <submit file>
```

which reports the cost in credits.
For more on `job_estimate`, execute `job_estimate --help`.

The SLURM command [`sacct`][sacct]
reports the resources used by a completed batch job,
which helps users learn what resources to request next time.
At the bottom of a batch script, the command
[sacct]: https://slurm.schedmd.com/sacct.html

```
sacct -j $SLURM_JOB_ID --format=JobID,JobName,MaxRSS,Elapsed,TotalCPU,State
```
generates a report in the batch output file of resources used.
(`$SLURM_JOB_ID` is a variable that returns the jobID of the batch job.)
As in the example, sacct takes formatting options to control what it prints;
`sacct --helpformat` lists all the options.

## Timing jobs

It is good practice to test a new workflow
by running small short jobs before submitting big long jobs.
To help plan your compute usage, 
it is helpful to time such test jobs.

Many well-designed applications display timing information
at the end of the log files they generate.
If this is not the case for your application,
you can find out how long a batch job takes
by sandwiching the commands you execute
between [`date`][date] commands:
[date]: https://man7.org/linux/man-pages/man1/date.1.html
```
date
<commands>
date
```
Your batch standard output file will then contain two "timestamps",
from which you can determine the running time.
To time a single command in a batch file, use [`time <command>`][time],
which will write timing information to standard output.
[time]: https://www.man7.org/linux/man-pages/man1/time.1.html


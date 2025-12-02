
# Batch jobs

For compute jobs that take hours or days to run,
instead of sitting at the terminal waiting for the results,
we submit a "batch job" to the workload manager,
which runs the job when resources are available.

## Slurm commands

On Roar, the workload manager is Slurm (Simple Linux Utility for Resource Management).  
Besides `salloc` for [interactive jobs](interactive-jobs.md)),
the basic Slurm commands are:

| Command | Effect|
| ---- | ---- | 
| `sbatch <script>` | submit batch job `<script>` | 
| `squeue -u <userid>` | check on jobs submitted by `<userid>` |
| `scancel <jobID>` | cancel the job | 

When you execute `sbatch myJob.sh`, Slurm responds with something like
```
Submitted batch job 25789352
```
To check on your jobs, execute `squeue -u <userID>`; Slurm responds with something like
```
JOBID		PARTITION	NAME		USER	ST	TIME	NODES	NODELIST(REASON)
25789352	open 		myJob.sh	abc123	R	1:18:31	1		p-sc-2008
```
Here ST = status:  PD = pending, R = running, C = completed.  
To cancel the job, execute `scancel 25789352`.

## Batch scripts

Jobs submitted to Slurm are in the form of a "batch script". 
A batch script is a shell script that executes commands, 
with a preamble of Slurm [resource directives](slurm-scheduler.md/#resource-directives) 
`#SBATCH...` to specify

- an **account** or **allocation** to charge;
- a **partition** (qos) to submit the job to;
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

`sbatch` can pass arguments to batch scripts like this:
```
sbatch myScript.sh arg1 arg2
```
In the script, arguments `arg1` and `arg2` can be accessed with `$1` and `$2` as usual.  
`sbatch` can also pass values by assigning variables like this:
```
sbatch --export=VAR1=arg1, VAR2=arg2 myScript.sh
```
In the script, `$VAR1` and `$VAR2` are set to `arg1` and `arg2`.

For more information on partitions, see [Partitions][partitions].  
For more information on resource requests, see [Resource requests][resource-requests].
[partitions]: ./resource-requests.md#partitions
[resource-requests]: resource-requests.md

!!! tip "Job Repository"
    For a repository of example batch workflows, go [here][repository].
[repository]: https://github.com/PSU-ICDS/rc-example-jobs

!!!warning "To use the open partition, use --partition=open"
	Unpaid jobs under the open partition cannot specify a hardware partition,
	but will be assigned to available older CPU hardware.

!!!warning "To use a paid allocation, use --partition=sla-prio"
	Jobs under a paid allocation do not specify the basic, standard,
	high-memory, or interactive partitions.
	Instead, --partition=sla-prio tells the job
	to use the hardware in your allocation.


# Batch jobs

For compute jobs that take hours or days to run,
instead of sitting at the terminal waiting for the results,
submit a "batch job" to the workload manager,
which runs the job when resources are available.

## Slurm commands

On Roar, the queue manager is Slurm (Simple Linux Utility for Resource Management).  
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

- an [account](../accounts/paid-resources.md) to charge;
- a [partition](../system/system-overview.md/#partitions) (type of nodes) to run on;
- nodes, cores, memory, GPUs, and time;
- and other job-related parameters.

For more information on using Slurm to request hardware, see [Hardware requests](resource-requests.md).

An example batch script:

```
#!/bin/bash
#SBATCH --account=account_id
#SBATCH --partition=basic
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=1gb
#SBATCH --time=4:00:00
#SBATCH --job-name=example-job
#SBATCH --output=example-job.%j.out

# load software
module load python/3.11.2

python3 myscript.py
```

!!! tip "To use a paid allocation, use --partition=sla-prio"
	Jobs under a paid allocation do not specify hardware partitions 
	(basic, standard, high-memory, or interactive).
	Instead, --partition=sla-prio tells the job
	to use the hardware in your allocation.


The first line `#!/bin/bash` is the "shebang", which says the script 
should be run under `bash` (a Linux shell).
Everything after the last `#SBATCH` are commands to be executed;
lines with `#` other than `#SBATCH` are ordinary bash script comments.

### Arguments

`sbatch` can pass arguments to batch scripts like this:

```
sbatch myScript.sh arg1 arg2
```

In the script, arguments `arg1` and `arg2` can be accessed with `$1` and `$2` as usual:

```
#!/bin/bash
#SBATCH --account=account_id
...

python3 myscript.py $1 $2
```
  
`sbatch` can also pass values by assigning variables like this:
```
sbatch --export=VAR1=arg1, VAR2=arg2 myScript.sh
```

In the script, `$VAR1` and `$VAR2` are set to `arg1` and `arg2`.

```
#!/bin/bash
#SBATCH --account=account_id
...

python3 myscript.py $VAR1 $VAR2
```

### Batch script examples

ICDS offers a curated repository of example submit scripts for many of our 
most popular software packages, including StarCCM, COMSOL, MATLAB, R, python, and more.

[ICDS Example Job Repository](https://github.com/PSU-ICDS/rc-example-jobs){ .md-button }


## Estimating credit usage

To learn how to estimate credit usage before running a batch job, 
go [here](../accounts/paid-resources.md/#estimating-job-costs).

### Timing jobs

It is good practice to test a new workflow
by running small short jobs before submitting big long jobs.
To help plan your compute usage, 
it is helpful to time such test jobs.

Many well-designed applications display timing information
at the end of the log files they generate.
Or, you can find out how long a batch job takes
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


## Recurring jobs

For jobs that need to run on a recurring schedule,
`scrontab` is a Slurm utility to schedule batch jobs to run at specified times, 
similar to the Unix `crontab` command.

### Using scrontab

To create or edit a cron schedule, `scrontab -e` opens an editor 
where you can specify when your batch jobs should run.
The syntax is similar to Unix crontab, with the addition of Slurm directives.

To view your current scrontab schedule, use `scrontab -l`. <br>
To remove your scrontab schedule, use `scrontab -r`.

### scrontab format

Each line in a scrontab file represents one scheduled job and has the format:

```
<minute> <hour> <day_of_month> <month> <day_of_week> <slurm_directives> <batch_script>
```

For example, to submit a batch job every day at 2:30 AM:

```
30 2 * * * --account=account_id --partition=basic /path/to/myjob.sh
```

The time fields work the same as standard Unix crontab:

- `<minute>`: 0-59
- `<hour>`: 0-23
- `<day_of_month>`: 1-31
- `<month>`: 1-12
- `<day_of_week>`: 0-6 (0 = Sunday)

Use `*` to match any value, or specify ranges and lists as needed.

For more information, see [Slurm scrontab documentation][scrontab].
[scrontab]: https://slurm.schedmd.com/scrontab.html


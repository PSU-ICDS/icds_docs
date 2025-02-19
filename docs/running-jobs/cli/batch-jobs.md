
# Batch Jobs

Jobs submitted to SLURM are in the form of a "batch script". A batch script is a shell script 
that executes commands, with a header of [Slurm directives](slurm.md/#slurm-resource-directives) 
which are prefixed by #SBATCH.

The three main portions of a batch script are:

 - **The shebang:** This defines the interpreter for the batch script. The most common one used is `#!/bin/bash` 
for the Bash interpreter.
 - **[Slurm directives](slurm.md/#slurm-resource-directives):** These are configuration settings used by 
the scheduler to allocate resources for your job. Required ones are `--mem`, `--time`, and `--ntasks`, 
but can be highly customized.
 - **Script commands:** commands in the form of a shell script to be executed once the job begins.

## Batch Scripts

Below is a sample Slurm script for running a Python script:

```
#!/bin/bash

#SBATCH --job-name=apythonjob
#SBATCH --partition=open
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=4G
#SBATCH --time=1:00:00

python pyscript.py
```

To submit a batch script, the [sbatch](https://slurm.schedmd.com/sbatch.html) command is used. For example, to submit a batch script called `pyjob.slurm`:

```
$ sbatch pyjob.slurm
```

To check the status of queued and running jobs, use the [squeue](#squeue) command:

```
$ squeue -u <userid>
```

## Compute Accounts and Partitions

### Open Queue

All users have access to the `open` compute account, which allows users to submit jobs free of charge. 

The `open` queue allows access to both the `open` and `interactive` partitions, which are subject to the following 
usage limits:

| Partition | Max Resources Per User | Max Job Run Time | 
| ---- | ---- | ---- |
| `open` | cpu=100,mem=800G | 48 hours |
| `interactive` | cpu=4,mem=64G | 48 hours |


To specify a partition within your batch job, use the `--partition` directive. For example, to use the 
`open` partition within your batch script, add the following line to your Slurm directives:
```
#SBATCH --partition=open
```

### Paid Accounts

For resources needs that do not fit well into the open queue, ICDS offers two different paid account options:

- [Allocations](../paid-resources/allocations.md): Reserved hardware allowing for instanteous usage at a 
flat, monthly rate
- [Credit/Pay-per-use](../paid-resources/credit-accounts.md): Flexible use model allowing for a variety of 
hardware use

A paid compute allocation provides access to specific compute resources for an individual user or for a group of users. 


## Job Management and Monitoring

### squeue

A user can find the job ID, the assigned node(s), and other useful information using the `squeue` command. 
Specifically, the following command displays all running and queued jobs for a specific user:

```
$ squeue -u <user>
```

A useful environment variable is the `SQUEUE_FORMAT` variable which enables customization of the details shown by the `squeue` command. 
This variable can be set, for example, with the following command to provide a highly descriptive `squeue` output:

```
$ export SQUEUE_FORMAT="%.9i %9P %35j %.8u %.2t %.12M %.12L %.5C %.7m %.4D %R"
```

Further details on the usage of this variable are available on Slurm's [squeue](https://slurm.schedmd.com/squeue.html) documentation page. 

### scontrol

Another useful job monitoring command is:
```
$ scontrol show job <jobid>
```

Also, a job can be cancelled with
```
$ scancel <jobid>
```

### Monitoring running jobs

Valuable information can be obtained by monitoring a job on the compute node(s) as the job runs. 

Use the [squeue](#squeue) command to identify which node(s) the job is running on, then use `ssh` to connect to 
the node directly. Once connected, the `top` and `ps` utilities can be used to monitor runnng processes on the node.

```
$ ssh <comp-node-id>
$ top -Hu <user>
$ ps -aux | grep <user>
```

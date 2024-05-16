
# Submitting Jobs




## Running Jobs with Slurm

The Roar Collab (RC) computing cluster is a shared computational resource. To 
perform computationally-intensive tasks, users must request compute resources 
and be provided access to those resources. The request/provision process allows 
the tasks of many users to be scheduled and carried out efficiently to avoid 
resource contention. [Slurm](https://slurm.schedmd.com) (Simple Linux Utility 
for Resource Management) is utilized by RC as the job scheduler and resource 
manager. Slurm is an open source, fault-tolerant, and highly scalable cluster 
management and job scheduling system for Linux clusters, and Slurm is rapidly 
rising in popularity and many other HPC systems use Slurm as well. Its primary 
functions are to
 
 - Allocate access to compute resources to users for some duration of time
 - Provide a framework for starting, executing, and monitoring work on the set of allocated compute resources
 - Arbitrate contention for resources by managing a queue of pending work

!!! warning
    Do not perform computationally intensive tasks on submit nodes. Submit a 
    resource request via Slurm for computational resources so your 
    computational task can be performed on a compute node.


### Slurm Resource Directives

Resource directives are used to request specific compute resources for a 
compute session.

| Resource Directive | Description |
| ---- | ---- |
| `-J` or `--job-name` | Specify a name for the job |
| `-A` or `--account` | Charge resources used by a job to specified account |
| `-p` or `--partition` | Request a partition for the resource allocation |
| `-N` or `--nodes` | Request a number of nodes |
| `-n` or `--ntasks` | Request a number of tasks |
| `--ntasks-per-node` | Request a number of tasks per allocated node |
| `--mem` | Specify the amount of memory required per node |
| `--mem-per-cpu` | Specify the amount of memory required per CPU |
| `-t` or `--time` | Set a limit on the total run time |
| `-C` or `--constraint` | Specify any required node features |
| `-e` or `--error` | Connect script's standard error to a non-default file |
| `-o` or `--output` | Connect script's standard output to a non-default file |
| `--requeue` | Specify that the batch job should be eligible for requeuing |
| `--exclusive` | Require exclusive use of nodes reserved for job |

Both standard output and standard error are directed to the same file by 
default, and the file name is `slurm-%j.out`, where the `%j` is replaced by the 
job ID. The output and error filenames are customizable, however, using the 
table of symbols below.

| Symbol | Description |
| :----: | ---- |
| `%j` | Job ID |
| `%x` | Job name |
| `%u` | Username |
| `%N` | Hostname where the job is running |
| `%A` | Job array's master job allocation number |
| `%a` | Job array ID (index) number |

Slurm makes use of environment variables within the scope of a job, and 
utilizing these variables can be beneficial in many cases.

| Environment Variable | Description |
| ---- | ---- |
| `SLURM_JOB_ID` | ID of the job |
| `SLURM_JOB_NAME` | Name of job |
| `SLURM_NNODES` | Number of nodes |
| `SLURM_NODELIST` | List of nodes |
| `SLURM_NTASKS` | Total number of tasks |
| `SLURM_NTASKS_PER_NODE` | Number of tasks per node |
| `SLURM_QUEUE` | Queue (partition) |
| `SLURM_SUBMIT_DIR` | Directory of job submission |

Further details on the available resource directives for Slurm are defined by 
Slurm in the documentation of the 
[salloc](https://slurm.schedmd.com/salloc.html) and 
[sbatch](https://slurm.schedmd.com/sbatch.html) commands.


### A Note on Requesting Resources

Requesting more resources for a job will increase its time in the queue as it 
must wait longer for resources to be allocated. Typically, parallelized code 
will see a reduction in overall runtime as more resources are requested. The 
total time to solution is ultimately reduced when the job strikes a balance by 
requesting the minimal amount of resources needed to provide a reasonable 
speedup. The goal of a resource request is to obtain the necessary 
computational resources to complete a task while minimizing the time to 
solution. An optimal resource request is the minimal amount of computational 
resources that allows a computational task to run to successful completion. 
It's useful to examine the amount of resources that a single laptop computer 
has, or **1 laptop-worth of resources**, as a reference. A modern above-average 
laptop, for example, may have an 8-core processor and 32 GB of RAM.  If a 
computational task can run on a laptop without crashing the device, then there 
is absolutely no need to submit a resource request larger than this.


### Interactive Jobs

The submit nodes of RC are designed to handle very simple tasks such as 
connections, file editing, and submitting jobs. Performing intensive 
computations on submit nodes will not only be computationally inefficient, but 
it will also adversely impact other users' ability to interact with the system. 
For this reason, users that want to perform computations interactively should 
do so on compute nodes using the 
[salloc](https://slurm.schedmd.com/salloc.html) command. 
To work interactively on a compute node with a single processor core for one 
hour, use the following command:

```
$ salloc --nodes=1 --ntasks=1 --mem=1G --time=01:00:00
```

The above command submits a request to the scheduler to queue an interactive 
job, and when the scheduler is able to place the request, the prompt will 
return. The hostname in the prompt will change from the previous submit node 
name to a compute node. Now on a compute node, intensive computational tasks 
can be performed interactively. This session will be terminated either when the 
time limit is reached or when the `exit` command is entered. After the 
interactive session completes, the session will return to the previous submit 
node.


### Interactive Jobs Through the Roar Collab Portal

The RC Portal is a simple graphical web interface that provides users with 
access to RC. Users can submit and monitor jobs, manage files, and run 
applications using just a web browser. To access the RC Portal, users must log 
in using valid Penn State access account credentials and must also have an 
account on RC. The [RC Portal](https://rcportal.hpc.psu.edu) is available at 
the following webpage: 
[https://rcportal.hpc.psu.edu](https://rcportal.hpc.psu.edu)


### Batch Jobs

On RC, users can run jobs by submitting scripts to the Slurm job scheduler. A 
Slurm script must do three things:

1. Prescribe the resource requirements for the job
2. Set the job's environment
3. Specify the work to be carried out in the form of shell commands

The portion of the job that prescribes the resource requirements contains the 
resource directives. Resource directives in Slurm submission scripts are 
denoted by lines starting with the `#SBATCH` keyword. The rest of the script, 
which both sets the environment and specifies the work to be done, consists of 
bash commands. The very first line of the submission script, `#!/bin/bash`, is 
called a *shebang* and specifies to the command line environment to interpret 
the commands as bash commands.

Below is a sample Slurm script for running a Python task:

```
#!/bin/bash

#SBATCH --job-name=apythonjob   # give the job a name
#SBATCH --account=open          # specify the account
#SBATCH --partition=open        # specify the partition
#SBATCH --nodes=1               # request a node
#SBATCH --ntasks=1              # request a task / cpu
#SBATCH --mem=1G                # request the memory required per node
#SBATCH --time=00:01:00         # set a limit on the total run time

python pyscript.py
```

In this sample submission script, the resource directives request a single node 
with a single *task*. Slurm is a task-based scheduler, and a task is equivalent 
to a processor core unless otherwise specified in the submission script. The 
scheduler directives then request 1 GB of memory per node for a maximum of 1 
minute of runtime. The memory can be specified in KB, MB, GB, or TB by using a 
suffix of K, M, G, or T, respectively. If no suffix is used, the default is MB. 
Lastly, the work to be done is specified, which is the execution of a Python 
script in this case.

The resource directives should be populated with resource requests that are 
adequate to complete the job but should be minimal enough that the job can be 
placed somewhat quickly by the scheduler. The total time to completion of a job 
consists of the amount of time the job is queued plus the amount of time it 
takes the job to run to completion once placed. The queue time is minimized 
when the bare minimum amount of resources are requested, and the queue time 
grows as the amount of requested resources grows. The run time of the job is 
minimized when all of the computational resources available to the job are 
efficiently utilized. The total time to completion, therefore, is minimized 
when the resources requested closely match the amount of computational 
resources that can be efficiently utilized by the job. During the development 
of the computational job, it is best to keep track of an estimate of the 
computational resources used by the job. Add about a 20% margin on top of the 
best estimate of the job's resource usage in order to produce a job's resource 
requests used in the scheduler directives.

If the above sample submission script was saved as `pyjob.slurm`, it would be 
submitted to the Slurm scheduler with the 
[sbatch](https://slurm.schedmd.com/sbatch.html) command.

```
$ sbatch pyjob.slurm
```

The job can be submitted to the scheduler from any node on RC. The scheduler 
will keep the job in the job queue until the job gains sufficient priority to 
run on a compute node. Depending on the nature of the job and the availability 
of computational resources, the queue time will vary between seconds to days. 
To check the status of queued and running jobs, use the 
[squeue](https://slurm.schedmd.com/squeue.html) command:

```
$ squeue -u <userid>
```


## Using Dedicated Partitions




### Open Queue

All RC users have access to the **open** queue, which allows users to submit 
jobs free of charge. The **open** queue has a maximum time request limit of 48 
hours and also has several other resource limits per user. The per-user 
resource limits for the **open** queue can be displayed with the following 
command:

```
$ sacctmgr show qos open format=name%10,maxtrespu%40
```

Jobs on the `open` queue will start and run only when sufficient idle compute 
resources are available. For this reason, there is no guarantee on when an 
`open` queue job will start. All users have equal priority on the `open` 
queue, but `open` queue jobs have a lower priority than jobs submitted to a 
paid compute allocation. If compute resources are required for higher priority 
jobs, then an `open` queue job may be cancelled so that the higher priority 
job can be placed. The cancellation of a running job to free resources for a 
higher priority job is called preemption. By using the `--requeue` option in a 
submission script, a job will re-enter the job queue automatically in the event 
that it is preempted. Furthermore, it is highly recommended for users to break 
down any large computational workflows into smaller, more manageable 
computational units so jobs can save state throughout the stages of the 
workflow. Saving state at set checkpoints will allow the computational workflow 
to return to the latest checkpoint, reducing the amount of required re-
computation in the case that a job is interrupted for any reason. RC has 
somewhat low utilization, however, so the vast majority of `open` queue jobs 
can be submitted and placed in a resonable amount of time. The `open` queue 
is entirely adequate for most individual users and for many use cases.


### Compute Allocations

A paid compute allocation provides access to specific compute resources for an 
individual user or for a group of users. A paid compute allocation provides the 
following benefits:

- Guaranteed job start time within one hour
- No time request limit
- No job preemption for non-burst jobs
- Burst capability up to 4x of the allocation's compute resources
- 5 TB of active group storage

A compute allocation results in the creation of a compute account on RC. The 
`mybalance` command on RC lists accessible compute accounts and resource 
information associated with those compute accounts. Use the `mybalance -h` 
option for additional command usage information.

To submit a job to a paid compute account, supply the `-A` or `--account` resource directive with the compute account name and supply the `-p` or `--partition` resource directive with `sla-prio`:

```
#SBATCH -A <compute_account>
#SBATCH -p sla-prio
```

To enable bursting, if enabled for the compute account, supply the `-p` or 
`--partition` resource directive with the desired level of bursting for the job 
(`burst2x`, `burst3x`, `burst4x`, and so on). To list the available compute 
accounts and the associated available burst partitions, use the following 
command:

```
$ sacctmgr show User $(whoami) --associations format=account%30,qos%40
```


#### Compute Resources Available

A paid compute allocation will typically cover a certain number of cores across 
a certain timeframe. The resources associated with a compute allocation are in 
units of **core-hours**. The compute allocation has an associated **Limit** in 
**core-hours** based on the initial compute allocation agreement. Any amount of 
compute resources used on the compute allocation results in an accrual of the 
compute allocation's **Usage**, again in **core-hours**. The compute 
allocation's **Balance** is simply the **Limit** minus its **Usage**.

```
Balance [core-hours] = Limit [core-hours] - Usage [core-hours]
```

At the start of the compute allocation, 60 days-worth of compute resources are 
added to the compute allocation's **Limit**. Each day thereafter, 1 day-worth 
of compute resources are added to the **Limit**.

```
Initial Resources   [core-hours] = # cores * 24 hours/day * 60 days
Daily Replenishment [core-hours] = # cores * 24 hours/day
```

The daily replenishment scheme continues on schedule for the life of the 
compute allocation. Near the very end of the compute allocation, the 
replenishment schedule may be impacted by the enforced limit on the maximum 
allowable **Balance**. The **Balance** for a compute allocation cannot exceed 
the amount of compute resources for a window of 91 days and cannot exceed the 
amount usable by a 4x burst for the remaining life of the compute allocation. 
This limit is only relevant for the replenishment schedule nearing the very end 
of the compute allocation life.

```
Max Allowable Balance [core-hours] = min( WindowMaxBalance, 4xBurstMaxBalance )

where

WindowMaxBalance  [core-hours] = # cores * 24 hours/day * 91 days
4xBurstMaxBalance [core-hours] = # cores * 24 hours/day * # days remaining * 4 burst factor
```


### Roar Collab Compute Account Self-Management




#### Modifying Allocation Coordinators

The principal contact for a compute allocation is automatically designated as a 
coordinator for the compute account associated with the compute allocation. A 
coordinator can add or remove another coordinator with the following command:

```
$ sacctmgr add coordinator account=<compute-account> name=<userid>
$ sacctmgr remove coordinator account=<compute-account> name=<userid>
```


#### Adding and Removing Users from an Allocation

A coordinator can then add and remove users from the compute account using the 
following:

```
$ sacctmgr add user account=<compute-account> name=<userid>
$ sacctmgr remove user account=<compute-account> name=<userid>
```


## Using GPUs

GPUs are available on RC to users that are added to paid GPU compute accounts. 
To use GPUs, add the `--gpus` resource directive:

```
#!/bin/bash

#SBATCH --job-name=apythonjob   # give the job a name
#SBATCH --account=<gpu_acct>    # specify the account
#SBATCH --partition=sla-prio    # specify the partition
#SBATCH --nodes=1               # request a node
#SBATCH --ntasks=1              # request a task / cpu
#SBATCH --mem=1G                # request the memory required per node
#SBATCH --gpus=1                # request a gpu
#SBATCH --time=00:01:00         # set a limit on the total run time

python pyscript.py
```

Only software that has been explicitly written to run on GPUs can take 
advantage of GPUs. Adding the `--gpus` option to a Slurm script for a CPU-only 
program will not speed up the execution time and will just waste resources and 
increase the queue time. Furthermore, some codes are only written to use a 
single GPU, so avoid requesting multiple GPUs unless the program can use them.


## Job Management and Monitoring

A user can find the job ID, the assigned node(s), and other useful information 
using the `squeue` command. Specifically, the following command displays all 
running and queued jobs for a specific user:

```
$ squeue -u <user>
```

A useful environment variable is the `SQUEUE_FORMAT` variable and can be set, 
for example, with the following command:

```
$ export SQUEUE_FORMAT="%.9i %9P %35j %.8u %.2t %.12M %.12L %.5C %.7m %.4D %R"
```

Further details on the usage of this variable are available on Slurm's 
[squeue](https://slurm.schedmd.com/squeue.html) documentation page. Another 
useful job monitoring command is:

```
$ scontrol show job <jobid>
```

Also, a job can be cancelled with
```
$ scancel <jobid>
```

Valuable information can be obtained by monitoring a job on the compute node(s) 
as the job runs. Connect to the compute node of a running job with the `ssh` 
command. Note that a compute node can only be reached if the user has a 
resource reservation on that specific node. After connecting to the compute 
node, the `top` and `ps` commands are useful tools.

```
$ ssh <comp-node-id>
$ top -Hu <user>
$ ps -aux | grep <user>
```


## Converting from PBS to Slurm

Slurm's commands and scheduler directives can be mapped to and from PBS/Torque 
commands and scheduler directives. To convert any PBS/Torque scripts and/or 
workflows to Slurm, the commands and scheduler directives should be swapped out 
and reconfigured. See the table below for the mapping of some common commands 
and scheduler directives:

| Action | PBS/Torque Command | Slurm Command |
| ---- | ---- | ---- |
| Submit a batch job | `qsub` | `sbatch` |
| Request an interactive job | `qsub -I` | `salloc` |
| Cancel a job | `qdel` | `scancel` |
| Check job status | `qstat` | `squeue` |
| Check job status for specific user | `qstat -u <user>` | `squeue -u <user>` |
| Hold a job | `qhold` | `scontrol hold` |
| Release a job | `qrls` | `scontrol release` |

| Resource Request | PBS/Torque Directive | Slurm Directive |
| ---- | ---- | ---- |
| Directive designator | `#PBS` | `#SBATCH` |
| Number of nodes | `-l nodes` | `-N` or `--nodes` |
| Number of CPUs | `-l ppn` | `-n` or `--ntasks` |
| Amount of memory | `-l mem` | `--mem` or `--mem-per-cpu` |
| Walltime | `-l walltime` | `-t` or `--time` |
| Compute account | `-A` | `-A` or `--account` |

For a more complete list of command, scheduler directive, and option 
comparisons, see the 
[Slurm Rosetta Stone](https://slurm.schedmd.com/rosetta.pdf).


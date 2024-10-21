
# Submitting Jobs




## Jobs with Slurm

The Roar computing clusters are shared computational resources. 
To perform computationally intensive tasks, users must request compute resources and be provided access to those resources. 
The request/provision process allows the tasks of many users to be scheduled and carried out efficiently to avoid resource contention. 
[Slurm](https://slurm.schedmd.com) is utilized by Roar as the job scheduler and resource manager. 
Slurm is an open source, fault-tolerant, and highly scalable cluster management and job scheduling system for Linux clusters. 
Slurm is rapidly rising in popularity and many other HPC systems use Slurm as well. 
Its primary functions are to
 
 - Allocate access to compute resources to users for some duration of time
 - Provide a framework for starting, executing, and monitoring work on the set of allocated compute resources
 - Arbitrate contention for resources by managing a queue of pending work

!!! warning

    Do not perform computationally intensive tasks on submit nodes. Submit a resource request via Slurm for computational resources so your computational task can be performed on a compute node.


### Slurm Resource Directives

A compute session can be reached via either a batch job or an interactive job. 
The following sections provide more details on intiating compute sessions: [Interactive Jobs](#interactive-jobs), [Interactive Jobs Through the Roar Portal](#interactive-jobs-through-the-roar-portal), and [Batch Jobs](#batch-jobs).

Resource directives are used to request a specific set of compute resources for a compute session. 
The following table lists some of the most useful resource directives.

| Resource Directive | Description |
| ---- | ---- |
| `-J` or `--job-name` | Specify a name for the job |
| `-A` or `--account` | Charge resources used by a job to a specified account |
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

Both standard output and standard error are directed to the same file by default, and the file name is `slurm-%j.out`, where the `%j` is replaced by the job ID. 
The output and error filenames are customizable, however, using the table of symbols below.

| Symbol | Description |
| :----: | ---- |
| `%j` | Job ID |
| `%x` | Job name |
| `%u` | Username |
| `%N` | Hostname where the job is running |
| `%A` | Job array's master job allocation number |
| `%a` | Job array ID (index) number |

Slurm makes use of environment variables within the scope of a job, and utilizing these variables can be beneficial in many cases.

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

Further details on the available resource directives for Slurm are defined by Slurm in the documentation of the [salloc](https://slurm.schedmd.com/salloc.html) and [sbatch](https://slurm.schedmd.com/sbatch.html) commands.


### Requesting Resources

The resource directives should be populated with resource requests that are adequate to complete the job but should be minimal enough that the job can be placed somewhat quickly by the scheduler. 
The total time to completion of a job is the sum of the time the job is queued plus the time it takes the job to run to completion once placed. 
The queue time is minimized when the bare minimum amount of resources are requested, and the queue time grows as the amount of requested resources grows. 
The run time of the job is minimized when all the computational resources available to the job are efficiently utilized. 
The total time to completion, therefore, is minimized when the resources requested closely match the amount of computational resources that can be efficiently utilized by the job. 
During the development of the computational job, it is best to keep track of an estimate of the computational resources used by the job. 
Add about a 20% margin on top of the best estimate of the job's resource usage to produce practical resource requests used in the scheduler directives.

It's useful to examine the amount of resources that a single laptop computer has, or **1 laptop-worth of resources**, as a reference. 
A modern above-average laptop, for example, may have an 8-core processor and 32 GB of RAM. 
If a computational task can run on a laptop without crashing the device, then there is absolutely no need to submit a resource request larger than this unless the job can efficiently utilize the additional resources.


### Interactive Jobs

The submit nodes are designed to handle very simple tasks such as connections, file editing, and submitting jobs. 
Performing intensive computations on submit nodes will not only be computationally inefficient, but it will also adversely impact other users' ability to interact with the system. 
For this reason, users that want to perform computations interactively should do so on compute nodes within an interactive compute session. 
Slurm's [salloc](https://slurm.schedmd.com/salloc.html) command is used to request an interactive compute session. 
To work interactively on a compute node with a single processor core for one hour, use the following command:

```
$ salloc --nodes=1 --ntasks=1 --mem=1G --time=01:00:00
```

Equivalently, short options can be used instead of the long options, so the abbreviated version of this command is instead

```
$ salloc -N 1 -n 1 --mem 1G -t 1:00:00
```

The above commands submit a request to the scheduler to queue an interactive job, and when the scheduler is able to place the request, the prompt will return. 
The hostname in the prompt will change from the previous submit node name to a compute node. 
Now on a compute node, intensive computational tasks can be performed interactively. 
This session is terminated either when the time limit is reached or when the `exit` command is entered. 
After the interactive session completes, the session will return to the previous submit node.


#### Interactive Jobs Through the Roar Portal

The Roar Portals are simple graphical web interfaces that provide users with access to Roar. 
Users can submit and monitor jobs, manage files, and run applications using just a web browser. 
To access the Roar Portals, users must log in using valid Penn State access account credentials and must also have an account on Roar. 

The [RC Portal](https://rcportal.hpc.psu.edu) is available at the following webpage: [https://rcportal.hpc.psu.edu](https://rcportal.hpc.psu.edu)

The [RR Portal](https://rrportal.hpc.psu.edu) is available at the following webpage: [https://rrportal.hpc.psu.edu](https://rrportal.hpc.psu.edu)


### Batch Jobs

Users can run batch jobs by submitting scripts to the Slurm job scheduler. 
A Slurm script must do three things:

1. Prescribe the resource requirements for the job
2. Set the job's environment
3. Specify the work to be carried out in the form of shell commands

The portion of the job that prescribes the resource requirements contains the resource directives. 
Resource directives in Slurm submission scripts are denoted by lines starting with the `#SBATCH` keyword. 
The rest of the script, which both sets the environment and specifies the work to be done, consists of shell commands. 
The very first line of the submission script, `#!/bin/bash`, is called a *shebang* and specifies that the commands in the script are to be interpreted by the bash shell in this case.

Below is a sample Slurm script for running a Python script:

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

In this sample submission script, the resource directives request a single node with a single *task*. 
Slurm is a task-based scheduler, and a task is equivalent to a processor core unless otherwise specified in the submission script. 
The scheduler directives then request 1 GB of memory per node for a maximum of 1 minute of runtime. 
The memory can be specified in KB, MB, GB, or TB by using a suffix of K, M, G, or T, respectively. 
If no suffix is used, the default is MB. 
Lastly, the work to be done is specified, which is the execution of a Python script in this case.

If the above sample submission script was saved as `pyjob.slurm`, it would be submitted to the Slurm scheduler with the following [sbatch](https://slurm.schedmd.com/sbatch.html) command.

```
$ sbatch pyjob.slurm
```

The job can be submitted to the scheduler from any node. 
It is important to note, however, that any jobs submitted from within another computational session will inherit any Slurm environment variables that are not reset within the submitted job.
The scheduler will keep the job in the job queue until the job gains sufficient priority to run on a compute node. 
Depending on the nature of the job and the availability of computational resources, the queue time can vary between seconds to days. 
To check the status of queued and running jobs, use the [squeue](https://slurm.schedmd.com/squeue.html) command:

```
$ squeue -u <userid>
```


## Compute Accounts and Partitions




### Open Queue

All RC users have access to the `open` compute account, which allows users to submit jobs free of charge. 
RR does not offer a free compute account, so users must submit jobs to a compute account provided by a paid compute allocation.


Under the `open` compute account on RC, the `open`, `short`, and `ic` partitions are available.
Any resource limitations associated with compute partitions are set by Slurm via a Quality of Service (QOS) with the same name as the partition.
The per-user resource limits defined by a QOS for any partition can be displayed with the following command:

```
$ sacctmgr show qos <partition> format=name%10,maxtrespu%40
```

For example, the per-user limits for the `open` partition are displayed by the following command:

```
$ sacctmgr show qos open format=name%10,maxtrespu%40
```

Jobs on the `open` compute account will start and run only when sufficient idle compute resources are available. 
For this reason, there is no guarantee on when an `open` job will start. 
All users have equal priority on the `open` compute account, but `open` jobs have a lower priority than jobs submitted to a paid compute account. 
If compute resources are required for higher priority jobs, then an `open` job may be cancelled so that the higher priority job can be placed. 
The cancellation of a running job to free resources for a higher priority job is called preemption. 
By using the `--requeue` option in a submission script, a job will re-enter the job queue automatically if it is preempted. 
Furthermore, it is highly recommended for users to break down any large computational workflows into smaller, more manageable computational units so jobs can save state throughout the stages of the workflow. 
Saving state at set checkpoints will allow the computational workflow to return to the latest checkpoint, reducing the amount of required re-computation in the case that a job is interrupted for any reason. 
RC has somewhat low utilization, however, so the vast majority of `open` jobs can be submitted and placed in a reasonable amount of time. 
The `open` compute account is entirely adequate for most individual users and for many use cases.

The `open` compute account can be specified using the `--account open` or `-A open` resource directive. To specify the partition, the `--partition <partition>` or `-p <partition>` resource directive is used.


### Compute Allocations

A paid compute allocation provides access to specific compute resources for an individual user or for a group of users. 
A paid compute allocation provides the following benefits:

- Guaranteed job start time within one hour
- No job preemption for non-burst jobs
- Burst capability up to 4x of the allocation's compute resources

A compute allocation results in the creation of a compute account on Roar. 
The `mybalance` command on Roar lists accessible compute accounts and resource information associated with those compute accounts. 
Use the `mybalance -h` option for additional command usage information.

To submit a job to a paid compute account, supply the `--account` or `-A` resource directive with the compute account name and supply the `--partition` or `-p` resource directive with `sla-prio`:

```
#SBATCH -A <compute_account>
#SBATCH -p sla-prio
```

To enable bursting, if enabled for the compute account, supply the `--partition burst` or `-p burst` resource directive.
Furthermore, the desired level of bursting for the job (`burst2x`, `burst3x`, `burst4x`, and so on) must be specified using the `--qos` resource directive. To enable 2x bursting for a batch job, for example, use the following resource directives:

```
#SBATCH -A <compute_account>
#SBATCH -p burst
#SBATCH --qos burst2x
```

To list the available compute accounts and the associated available burst partitions, use the following command:

```
$ sacctmgr show User $(whoami) --associations format=account%30,qos%40
```


#### Modifying Allocation Coordinators

The principal contact for a compute allocation is automatically designated as a coordinator for the compute account associated with the compute allocation. 
A coordinator can add or remove another coordinator with the following command:

```
$ sacctmgr add coordinator account=<compute-account> name=<userid>
$ sacctmgr remove coordinator account=<compute-account> name=<userid>
```


#### Adding and Removing Users from an Allocation

A coordinator can then add and remove users from the compute account using the following:

```
$ sacctmgr add user account=<compute-account> name=<userid>
$ sacctmgr remove user account=<compute-account> name=<userid>
```


#### Available Compute Resources

A paid compute allocation will typically cover a certain number of cores across a certain timeframe. 
The resources associated with a compute allocation are in units of **core-hours**. 
The compute allocation has an associated **Limit** in **core-hours** based on the initial compute allocation agreement. 
Any amount of compute resources used on the compute allocation results in an accrual of the compute allocation's **Usage**, again in **core-hours**. 
The compute allocation's **Balance** is simply the **Limit** minus its **Usage**.

```
Balance [core-hours] = Limit [core-hours] - Usage [core-hours]
```

At the start of the compute allocation, 60 days-worth of compute resources are added to the compute allocation's **Limit**. 
Each day thereafter, 1 day-worth of compute resources are added to the **Limit**.

```
Initial Resources   [core-hours] = # cores * 24 hours/day * 60 days
Daily Replenishment [core-hours] = # cores * 24 hours/day
```

The daily replenishment scheme continues on schedule for the life of the compute allocation. 
Near the very end of the compute allocation, the replenishment schedule may be impacted by the enforced limit on the maximum allowable **Balance**. 
The **Balance** for a compute allocation cannot exceed the amount of compute resources for a window of 91 days and cannot exceed the amount usable by a 4x burst for the remaining life of the compute allocation. 
This limit is only relevant for the replenishment schedule nearing the very end of the compute allocation life.

```
Max Allowable Balance [core-hours] = min( WindowMaxBalance, 4xBurstMaxBalance )

where

WindowMaxBalance  [core-hours] = # cores * 24 hours/day * 91 days
4xBurstMaxBalance [core-hours] = # cores * 24 hours/day * # days remaining * 4 burst factor
```


#### Using GPUs

GPUs are available to users that are added to paid GPU compute accounts. 
To request GPU resources, use the `--gpus` resource directive:

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

Requesting GPU resources for a job is only beneficial if the software running within the job is GPU-enabled.


## Job Management and Monitoring

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

Another useful job monitoring command is:
```
$ scontrol show job <jobid>
```

Also, a job can be cancelled with
```
$ scancel <jobid>
```

Valuable information can be obtained by monitoring a job on the compute node(s) as the job runs. 
Connect to the compute node of a running job with the `ssh` command. 
Note that a compute node can only be reached if the user has a resource reservation on that specific node. 
After connecting to the compute node, the `top` and `ps` commands are useful tools.

```
$ ssh <comp-node-id>
$ top -Hu <user>
$ ps -aux | grep <user>
```


## Converting from PBS to Slurm

Slurm's commands and scheduler directives can be mapped to and from PBS/Torque commands and scheduler directives. 
To convert any PBS/Torque scripts and/or workflows to Slurm, the commands and scheduler directives should be swapped out and reconfigured. 
See the table below for the mapping of some common commands and scheduler directives:

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

For a more complete list of command, scheduler directive, and option comparisons, see the [Slurm Rosetta Stone](https://slurm.schedmd.com/rosetta.pdf).



# Submitting Jobs

## Interactive Jobs Through the RC Portal

The Roar Collab (RC) Portal is a simple graphical web interface that provides users with access to RC. Users can submit and monitor jobs, manage files, and run applications using just a web browser. To access the RC Portal, users must log in using valid Penn State access account credentials and must also have an account on RC. [The RC Portal](https://rcportal.hpc.psu.edu) is available at the following webpage: [https://rcportal.hpc.psu.edu](https://rcportal.hpc.psu.edu)


## Running Jobs with Slurm

The RC computing cluster is a shared computational resource. To perform computationally-intensive tasks, users must request compute resources and be provided access to those resources. The request/provision process allows the tasks of many users to be scheduled and carried out efficiently to avoid resource contention. [Slurm](https://slurm.schedmd.com) (Simple Linux Utility for Resource Management) is utilized by RC as the job scheduler and resource manager. Slurm is an open source, fault-tolerant, and highly scalable cluster management and job scheduling system for Linux clusters, and Slurm is rapidly rising in popularity and many other HPC systems use Slurm as well. Its primary functions are to
 - Allocate access to compute resources to users for some duration of time
 - Provide a framework for starting, executing, and monitoring work on the set of allocated compute resources
 - Arbitrate contention for resources by managing a queue of pending work


### Slurm Resource Directives

| Command | Description |
| ---- | ---- |
| -A or --account | Charge resources used by this job to specified account |
| -p or --partition | Request a specific partition for the resource allocation |
| -N or --nodes | Request a number of nodes |
| -n or --ntasks | Request a number of tasks |
| --ntasks-per-node | Request a number of tasks per allocated node |
| --mem | Specify the amount of memory required per node |
| --mem-per-cpu | Specify the amount of memory required per CPU |
| -t or --time | Set a limit on the total run time of the job |
| -J or --job-name | Specify a name for the job |

Further details on the available resource directives for Slurm are defined by Slurm in the documentation of the [salloc](https://slurm.schedmd.com/salloc.html) and [sbatch](https://slurm.schedmd.com/sbatch.html) commands.


### Interactive Jobs

The submit nodes of RC are designed to handle very simple computational tasks such as connections, file editing, and submitting jobs. Performing intensive computations on submit nodes will not only be computationally inefficient, but it will also adversely impact other users' ability to interact with the system. For this reason, users that want to perform computations interactively should do so on compute nodes using the [salloc](https://slurm.schedmd.com/salloc.html) command. To work interactively on a compute node with a single processor core for half an hour, use the following command:
```
$ salloc --nodes=1 --ntasks=1 --mem=1G --time=00:30:00
```

The above command submits a request to the scheduler to queue an interactive job, and when the scheduler is able to place the request, the prompt will return. The hostname in the prompt will change from the previous submit node name to a compute node. Now on a compute node, intensive computational tasks can be performed interactively. This session will be terminated either when the time limit is reached or when the `exit` command is entered. After the interactive session completes, the session will return to the previous submit node.



### Batch Jobs

On Roar Collab (RC), users can run jobs by submitting scripts to the Slurm job scheduler. A Slurm script must do three things:

1. prescribe the resource requirements for the job
2. set the job's environment
3. specify the work to be carried out in the form of shell commands

The portion of the job that prescribes the resource requirements consists of the scheduler directives. Scheduler directives in Slurm submission scripts are denoted by lines starting with the `#SBATCH` keyword. The rest of the script, which both sets the environment and specifies the work to be done, consists of bash commands. The very first line of the submission script, `#!/bin/bash`, is called a *shebang* and specifies to the command line environment to interpret the commands as bash commands.

Below is a sample Slurm script for running a Python task using a Conda environment

```
#!/bin/bash

#SBATCH --job-name=apythonjob      # give the job a name
#SBATCH --account=open		   # specify the account
#SBATCH --partition=open	   # specify the partition
#SBATCH --nodes=1		   # request a node
#SBATCH --ntasks=1		   # request a task / cpu
#SBATCH --mem=1G		   # request the memory required per node
#SBATCH --time=00:01:00		   # set a limit on the total run time

module purge
module load anaconda
conda activate py_env

python pyscript.py
```

In this sample submission script, the scheduler directives request a single node with a single *task*. Slurm is a task-based scheduler, and a task is equivalent to a processor core unless otherwise specified in the submission script. The scheduler directives then request 1 GB of memory per node for a maximum of 1 minute of runtime. The memory can be specified in KB, MB, GB, or TB by using a suffix of K, M, G, or T, respectively. If no suffix is used, the default is MB. The next block of the submission script sets the environment for the job by loading the **anaconda** module and then activating the **py_env** conda environment. Lastly, the work to be done is specified, which is the execution of a Python script.

The scheduler directives should be populated with resource requests that are adequate to complete the job but should minimal enough that the job can be placed somewhat quickly by the scheduler. The total time to completion of a job consists of the amount of time the job is queued plus the amount of time it takes the job to run to completion once placed. The queue time is minimized when the bare minimum amount of resources are requested, and the queue time grows as the amount of requested resources grow. The run time of the job is minimized when all of the computational resources available to the job are efficiently utilized. The total time to completion, therefore, is minimized when the resources requested closely match the amount of computational resources that can be efficiently utilized by the job. During the development of the computational job, it is best to keep track of an estimate of the computational resources used by the job. Add about a 20% margin on top of the best estimate of the job's resource usage in order to produce a job's resource requests used in the scheduler directives.

If the above sample submission script was saved as **pyjob.slurm**, it would be submitted to the Slurm scheduler with the [sbatch](https://slurm.schedmd.com/sbatch.html) command.
```
$ sbatch pyjob.slurm
```

The job should be submitted to the scheduler from a submit node on RC. The scheduler will keep the job in the job queue until the job gains sufficient priority to run on a compute node. Depending on the nature of the job and the availability of computational resources, the queue time will vary between seconds to days. To check the status of queued and running jobs, use the [squeue](https://slurm.schedmd.com/squeue.html) command:
```
$ squeue -u <userid>
```


## Using Dedicated Partitions

### RC Account Self-Management

#### Modifying Allocation Coordinators

#### Adding and Removing Users from an Allocation

## Using GPUs

GPUs are available on RC. To use GPUs, add a scheduler directive with the **--gres** option:

```
#!/bin/bash

#SBATCH --job-name=apythonjob      # give the job a name
#SBATCH --account=open             # specify the account
#SBATCH --partition=open           # specify the partition
#SBATCH --nodes=1                  # request a node
#SBATCH --ntasks=1                 # request a task / cpu
#SBATCH --mem=1G                   # request the memory required per node
#SBATCH --gres=gpu:1		   # request a gpu
#SBATCH --time=00:01:00            # set a limit on the total run time

module purge
module load anaconda
source activate py_env

python pyscript.py
```

Only software that has been explicitly written to run on GPUs can take advantage of GPUs. Adding the **--gres** option to a Slurm script for a CPU-only program will not speed up the execution time and will just waste resources and increase the queue time. Furthermore, some codes are only written to use a single GPU, so avoid requesting multiple GPUs unless the program can use them.



## Job Management and Monitoring

`ssh` to compute node and use `top` and `ps`. `sreport`

## Converting from PBS to Slurm


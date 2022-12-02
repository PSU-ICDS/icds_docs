---
title: Using Compute Resources
---


# Submitting on Roar

## Interactive Jobs

Interactive jobs may be submitted to ACI-b using the -I (for interactive) flag. Interactive jobs require resource requests and an allocation. An interactive job can be submitted using a command similar to:

`qsub -A open -l walltime=1:00:00 -l nodes=1:ppn=2 -I`

The job will be given a job ID and your session will wait until this job has the resources to start. You will then be placed on the compute node and given a usable terminal session within your current session. For example a user submitting an interactive job may see

```
[abc123@aci-lgn-001 ~]$ qsub I l nodes=1:ppn=1 l walltime=4:00:00 -A open

qsub: waiting for job <span style="word-wrap: break-word;">2449840.torque01.util.production.int.aci.ics.psu.edu</span> u to start

qsub: job <span style="word-wrap: break-word;">2449840.torque01.util.production.int.aci.ics.psu.edu</span> ready

[abc123@comp-bc-0267 ~]$

```

Note that the node the user is on changes from log-in node (aci-lgn-001) to a basic core compute node (comp-bc-0267) when the job starts. You can ask for x-windows to be displayed using the `-X` flag with the `qsub` command, as long as you have logged into ACI-b using the `-Y` flag with `ssh`. Note that some users experiencing difficulty with interactive x-windows on ACI-b jobs will often use an Open OnDemand interactive session to connect to ACI-i, and then `ssh` with the `-Y` flag to ACI-b from ACI-i.  

It is recommended that you compile your code using an interactive job on the nodes that your job will run.  

## Batch Jobs

Jobs are submitted from the head nodes of ACI-b and will run when dedicated resources are available on the compute nodes. Roar uses Moab and Torque for the scheduler and resource manager. Jobs can be either run in batch or interactive modes. Both are submitted using the qsub command.  

Both batch and interactive jobs are required to provide a list of requested resources to the scheduler in order to be placed on a compute node with the correct resources available. These are given either in the submission script or on the command line. If these are given in a submission script, they must come before any non-PBS command.  

Typical PBS directives are:

|PBS Directive|Description|
|--- |--- |
|#PBS -l walltime=HH:MM:SS|This specifies the maximum wall time (real time, not CPU time) that a job should take. If this limit is exceeded, PBS will stop the job. Keeping this limit close to the actual expected time of a job can allow a job to start more quickly than if the maximum wall time is always requested.|
|#PBS -l pmem=SIZEgb|This specifies the maximum amount of physical memory used by any processor ascribed to the job. For example, if the job would run on four processors and each would use up to 2 GB (gigabytes) of memory, then the directive would read #PBS -l pmem=2gb. The default for this directive is 1 GB of memory.|
|#PBS -l mem=SIZEgb|This specifies the maximum amount of physical memory used in total for the job. This should be used for single node jobs only.|
|#PBS -l nodes=N:ppn=M|This specifies the number of nodes (nodes=N) and the number of processors per node (ppn=M) that the job should use. PBS treats a processor core as a processor, so a system with eight cores per compute node can have ppn=8 as its maximum ppn request. Note that unless a job has some inherent parallelism of its own through something like MPI or OpenMP, requesting more than a single processor on a single node is usually wasteful and can impact the job start time.|
|#PBS -l nodes=N:ppn=M:O||

Node types available on Roar:  

|Node Type = O|CPU|RAM|
|--- |--- |--- |
|basic|Intel Xeon E5-2650v4 2.2GHz|128 GB Total|
|lcivybridge  
scivybridge|Intel Xeon E5-2680v2 2.8GHz|256 GB Total|
|schaswell|Intel Xeon E5-2680v3 2.5GHz|256 GB Total|
|himem|Intel Xeon E7-4830v2 2.2GHz|1024 GB Total|


### PBS Submit Files

The following is a submission script for a Matlab job that will run for 5 minutes on one processor using the open queue.

```
#!/bin/bash

#PBS -l nodes=1:ppn=1

#PBS -l walltime=5:00

#PBS -A open

# Get started

echo "Job started on $(hostname) at $(date)"

# Load in matlab

module purge

module load matlab

# Go to the correct place

cd $PBS_O_WORKDIR

# Run the job itself - a matlab script called runThis.m

matlab-bin -nodisplay -nosplash < runThis.m > log.matlabRun

# Finish up

echo "Job Ended at $(date)"

```

This script would be submitted using the command

`qsub subScript.pbs`

from the directory containing the submission and matlab scripts.  

  


## Using dedicated partitions

All jobs submitted to an allocation that have available resources are guaranteed to start within 1 hour. Note that the resources include both available hours as well as the requested resources. For example, a group that has a 40 core allocations on two standard memory nodes is limited to the RAM and CPUs on both nodes. Single processor jobs that request most of the memory on the nodes may block other jobs from running, even if CPUs are idle.  

Users submitting to an allocation can run in ‘burst’ mode. Your group may use a number of cores up to four times your Core Limit (referred to as your 4x Core Limit). When your group submits jobs that exceed your Core Limit, you are considered to be ‘bursting,’ and your jobs will run on our Burst Queue. Bursting consumes your allocation faster than normal. How much you can burst is determined by your 90-day sliding window.  

How much you can use Roar is governed by the size of your allocation and how much you have used the system in the past 90 days. In any given 90-day period, you may use up to your Core Limit times the number of hours in 90 days (2160). The amount of core-hours you have available is governed by a 90-day sliding window, such that the core-hours you use in any given day become available again after 90 days.  

**How is My Allocation "Charged" for a Batch Job?**

The charge associated with a job is dependent on the total number of requested cores and the actual runtime of the job (in seconds):

NumberOfCores*Runtime.

For example, if a 20 core job has a total runtime of 1 hour the charge to the GReaT allocation is 20*3600=7200 core seconds. Please note that the charge includes the number of requested cores, not the number of utilized cores. Additionally, the requested walltime and actual runtime of the job may differ.

**Note:** In the tables below, run times are noted in hours to simplify the examples. In practice, allocations are charged for usage by the second.

<span class="cmbx-10">Example:</span> If you have a 20-core allocation, you can consume 43,200 (20 * 2160) core-hours within any given 90-day period. Your average rate of usage in any 90-day period cannot exceed 20 cores per hour. Core-hours you use on the first day of your allocation will become available again on the 91st day; core-hours you use on the second day become available again on the 92nd day; and so on. If you never burst, you can use all your cores continuously.  

<span class="cmbx-10">Example:</span> With your 20-core allocation, you run jobs requiring 20 cores continuously. In any given 90-day period, you will use 43,200 core-hours, and your average rate of usage is 20 cores per hour.

|Day|Core-Hours Available|Usage on this Day|Core-Hours Used This Day|
|--- |--- |--- |--- |
|1|43,200|20 cores x 24 hours|480|
|2|42,720|20 cores x 24 hours|480|
|3|42,240|20 cores x 24 hours|480|
|4|41,760|20 cores x 24 hours|480|


Usage continues at the same rate of 20 cores, 24 hours per day.

|Day|Core-Hours Available|Usage on this Day|Core-Hours Used This Day|
|--- |--- |--- |--- |
|90|480|20 cores x 24 hours|480|
|91|480|20 cores x 24 hours|480|
|92|480|20 cores x 24 hours|480|


Note that on Day 91, the core-hours used on Day 1 become available again; on Day 92, the core-hours used on Day 2 become available again; and so on.  

<span class="cmbx-10">Example:</span> Bursting above your allocation may lead to days with 0 hours available.

|Day|Core-Hours Available|Usage on this Day|Core-Hours Used This Day|
|--- |--- |--- |--- |
|1|43,200|20 cores x 24 hours|480|
|2|42,720|80 cores x 24 hours|1920|
|3|40,800|80 cores x 24 hours|1920|
|4|38,8801,760|80 cores x 24 hours|1920|


Usage continues at the same rate of 80 cores, 24 hours per day.

|Day|Core-Hours Available|Usage on this Day|Core-Hours Used This Day|
|--- |--- |--- |--- |
|24|480|60 cores x 8 hours|480|
|25|0|0|0|
|26|0|0|0|


At this point, no core-hours are available, and no jobs can be run against the allocation until Day 91, when the core-hours used on Day 1 become available again.

|Day|Core-Hours Available|Usage on this Day|Core-Hours Used This Day|
|--- |--- |--- |--- |
|91|480|20 cores x 24 hours|480|
|92|1920|0|0|
|93|3840|20 cores x 24 hours|480|


<span class="cmbx-10">Identifying Allocation Usage:</span>  

Users are able to see their allocations with the balance using the command mam-list-funds. This is typically used with the -h flag to show the allocation and balance in hours.

`mam-list-funds -h`

The allocation topology, end date and node-type can be shown using the mam-list-accounts command.

`mam-list-accounts`

Note that this shows you expired allocations as well. The second column (Active) will show True for active allocations and False for expired allocations.  

Users interested in their own usage may want to investigate several of the other mam commands:

`mam-list-usagerecords
mam-list-transactions
`

## WIP: Using GPUs

Isolate the Roar specific details here and place general in an an external document such as [Using GPUs](99_using_gpus.md)

## Job Management and Monitoring

There are several ways to view existing jobs. The `qstat` command can give some basic information about your own queued and running jobs.

`qstat`

Some helpful flags are `-u` (user), `-s` (status), `-n` (to show the nodes running jobs are placed on) and -f to show more information for a specified job. For example, to view more information about job 536, you can use the command

`qstat -f 536`

Common status for jobs are Q for queued, R for running, E for ending, H for being held and C for complete.  

You can also view all of the jobs running, waiting and being held using the showq command:

`showq`

It may be helpful for you to view all of the jobs running on an allocation. For example, if you are a member of the abc123_a_g_sc_default allocation, you can view the running and queued jobs using the command:

`showq -w acct=abc123_a_g_sc_default`

You may delete your jobs using the qdel command. For example, the job 546 may be deleted using the command:

`qdel 546`

Jobs that are not responding may require being purged from the nodes. You can do this with the `-p` flag:

`qdel -p 546`

Note that you are only able to delete your own jobs, not other users.  

You can use the checkjob command to view some additional information about queued and running jobs. For example, to give very verbose information about job 548, you can use the command:

`checkjob 548 -v -v`

# Submitting on Roar Collab

Roar Collab is the newest high performance research computing cluster managed by ICDS. Designed with collaboration in mind, the Roar Collab environment will allow for more frequent software updates and hardware upgrades to keep pace with researchers’ changing needs.

Still in its early stages, Roar Collab is currently only available “by invitation” so that we may ensure its limited resources not oversubscribed. As new resources are added, Roar Collab will become available to more users. [Learn more about our plans for expanding this resource here.](https://www.icds.psu.edu/computing-services/roar-collab/)

Roar Collab uses the [Slurm workload manager](https://slurm.schedmd.com/documentation.html) to manage job submission. Once a job is submitted, Slurm will match the job to available resources.

There are two primary methods of running jobs with Slurm – [interactively](https://www.icds.psu.edu/running-interactive-jobs-on-roar-collab/) or via [batch scheduling](https://www.icds.psu.edu/running-batch-jobs-on-roar-collab/). Both methods use [Slurm directives](https://www.icds.psu.edu/converting-moab-roar-submission-scripts-to-slurm-roar-collab/) to define required resources.

## Interactive Jobs

Interactive jobs allow a user to use compute resources while running commands and viewing output in real-time.

**Note:** To prevent performance issues for all users, intensive tasks such as code compilation and workflow troubleshooting should be done within interactive jobs.

To start an interactive job, use the “salloc” command. Using Slurm directives, job resource requirements can be customized. For example, to start a job over 4 cores and lasting 3 hours enter:

$ salloc -N 1 -n 4 --mem-per-cpu=1024 -t 3:00:00

## Batch Jobs

To submit batch jobs, use the `sbatch` command to submit a job submit script to the scheduler. To highlight how this works, let’s use this basic script (called python.sh) as an example:

#!/bin/bash 
module load python/3.6 
python hello_world.py 

To submit this script as a batch job using the default parameters, the command would be:

$ sbatch python.sh 

### SLURM Directives

Job submit scripts are batch scripts with added #SBATCH directives to outline the resources desired by the scheduler. These directives can be placed at the top of the submit script, as shown below:

	#!/bin/bash 
	#SBATCH --nodes=1 
	#SBATCH --ntasks=1 
	#SBATCH --mem=1GB 
	#SBATCH --time=1:00:00 
	#SBATCH --partition=open 

	module load python/3.6 
	python hello_world.py 



Alternatively, directives can be specified inline when you submit using `sbatch`

Here is an example of inline directives requesting a single core on a single node with 1 GB of RAM for 1 hour on the Open queue:

	$ sbatch -N 1 -n 1 --mem=1GB -t 1:00:00 -p open python.sh 

Here are some common directives used:

|Command|Description|
|--- |--- |
|--nodes (-N)|Number of nodes requested|
|--time (-t)|Maximum wall time for the job – in DD-HHH:MM:SS format|
|--mem|Real memory (RAM) required per node - can use KB, MB, and GB units – default is MB  

Request less memory than total available on the node - The maximum available on a 512 GB RAM node is 500, for 256 GB RAM node is 250|
|--ntasks (-n)|The number of tasks total – used to request a specific number of cores|
|--ntasks-per-node|Number of tasks per node – used to request a specific number of cores  
This value multiplied by the number of nodes requested will equal total allocated cores|
|--mem|Minimum of memory allocated to entire job|
|--mem-per-cpu|Minimum of memory required per allocated CPU|
|--output|Filename where all STDOUT will be directed – default is Slurm-.out|
|--error|Filename where all STDERR will be directed – default is Slurm-.out|
|--job-name|How the job will show up in the queue|


More directives can be found in [the Slurm documentation](https://slurm.schedmd.com/sbatch.html).

## Using dedicated partitions


To run jobs on dedicated allocations on Slurm, first specify the allocation, and then specify whether to run the job in “sla-prio” or “burst” partition.

The sla-prio (or “service level agreement priority”) partition gives your job priority status according to your SLA or paid allocation.

The “burst” partition allows your job to utilize up to 4 times the resources allocated in your SLA.

For example, to run on a dedicated allocation in the sla-prio partition, include the following directives in the submit script:

	#SBATCH --account=<sla_id> 
	#SBATCH --partition=sla-prio 

**Note:** Resource requests must fit the allocation specifications, or the job will not start.

To utilize burst, change partition to “burst” and include the “qos” directive to specify how much to burst. You may specify “burst2x,” “burst3x,” or “burst4x” to use 2, 3, or 4 times the resources, respectively. For example, to burst to 4 times the allocated resources use the following:

	#SBATCH --account=<sla_id> 
	#SBATCH --partition=burst 
	#SBATCH --qos=burst4x 


# Managing Your Paid Allocation on Roar Collab



If you have a paid allocation on Roar Collab, these procedures can help you monitor your account balance and adjust access and admin privileges.

### Check your compute balance

Use the “mybalance” command. For example:

$ mybalance

Project                     Limit         Used      Balance  Resource Limits

--------------------  -----------    ---------     --------  ---------------

dml129-engagement          67200.0      11530.7      55669.3  cpu=40,gres/gpu=0,mem=320G

dml129-engagement_gpu      80640.0          0.0      80640.0  cpu=48,gres/gpu=2,mem=384G

gctest                                     81.3               cpu=48,gres/gpu=2,mem=384G

open                                   387156.4               

sctest                                      9.2               cpu=24,mem=192G

### Check your storage balance

Use “check_storage_quotas.”

### Check the accounts associated with a user

Use the “sacctmgr” command. For example:

-s show account format=Account%20,grptres%30,GrpCPUMins,qos%30 where account=<account name> where user=''

…generates:

       Account                        GrpTRES  GrpCPUMins                            QOS                Descr 

-------------------- ------------------------------ ----------- ------------------------------ -------------------- 

   dml129-engagement     cpu=40,gres/gpu=0,mem=320G     4032000 burst2x,burst3x,burst4x,normal           [ntype=sc]


### Add or remove coordinators

Coordinators are users with administrative abilities over user access. The coordinator can add or remove users from a paid allocation.

By default, the coordinator of an allocation is the faculty sponsor. Existing coordinators can add or remove other coordinators. 

**IMPORTANT:** Because coordinators can manage both user and coordinator access to the allocation, please exercise restraint when granting coordinator permissions. 

To add a user as a coordinator, use the command `sacctmgr`:

$ sacctmgr add coordinator account=<sla_id> name=<user_id> 

To remove an existing coordinator:

$ sacctmgr remove coordinator account=<sla_id> name=<user_id> 

### Add or remove users to an allocation

Active coordinators can add and remove user access to paid allocations using the sacctmgr command as well. To add a user to an SLA, the command would be:

	$ sacctmgr add user account=<sla_id> name=<user_id> 

To remove a user’s access to an allocation, the coordinator would use the command:

	$ sacctmgr remove user account=<sla_id> name=<user_id> 

## Using GPUs


GPUs can be requested with the “- -gpu” directive. For example, to submit a job to run on a GPU enabled node, add the following line to the submit script:

#SBATCH --gpus=<n> 

Or specify the directive inline when using  “sbatch”:

$ sbatch --gpu=2 <submit_script> 

## Job Management and Monitoring

To check the status of submitted jobs, use the “squeue” command. Using `squeue` without any options lists all pending and running jobs on the cluster. To see only the jobs submitted by a particular user id, add the following:

$ squeue -u <user_id> 



To cancel jobs, use `scancel`. To cancel a single job, specify the job id:

$ scancel <job_id> 



To cancel all jobs by a specific user, specify a user id:

$ scancel -u <user_id> 

# How to Transition from Roar to Roar Collab


Most users of Roar will find the switch to the Roar Collab environment quite simple, but following these steps can help to ensure a smooth transition.

**1\. Activate your Roar Collab account**

Need help? Contact us at [icds@psu.edu](mailto:icds@psu.edu).

**2\. Set up your Roar Collab compute and storage allocations**

If your work will require the resources of a paid allocation, contact us at [icds@psu.edu](mailto:icds@psu.edu)to discuss your options.

**3\. Change coordinators or users of your allocation**

If you have a paid allocation, [you can manage who may submit jobs against your account and more.](https://www.icds.psu.edu/managing-your-paid-allocation-on-roar-collab/)

**4\. Transfer your data into Roar Collab.**

Roar and Roar Collab have independent file systems, so you’ll need to transfer personal data from work and home. Users with paid allocations will also need to transfer active storage from group. [Learn how to transfer files here.](https://www.icds.psu.edu/transferring-data-to-and-from-roar-collab/)

**5\. Check for available software**

Check the Central Software Stack and RISE Software Stack. If you can’t find what you need, you can install software locally or [request that ICDS install software on Roar Collab](https://www.icds.psu.edu/roar-collab-software-request-form/).

**6\. Modify your submission scripts**

Roar Collab uses the Slurm job scheduler. [If you have submission scripts written for Roar (which utilizes the MOAB/Torque scheduler) you’ll need to convert these scripts.](https://www.icds.psu.edu/converting-moab-roar-submission-scripts-to-slurm-roar-collab/) Additionally, be sure to change any file paths to match Roar Collab directory structure.

**7\. Run a test job**

Once you have everything set up, it’s a good idea to run a simple test job. For guidance, see [Submitting Jobs on Roar Collab](https://www.icds.psu.edu/submitting-jobs-on-roar-collab/).

**8\. Cancel Roar compute and storage allocations to avoid duplicate billing**

If you have time remaining on an existing Roar allocation that you no longer need, <span class="TextRun SCXW171339399 BCX0" xml:lang="EN-US" data-contrast="auto" lang="EN-US"><span class="NormalTextRun SCXW171339399 BCX0">contact us at [icds@psu.edu ](mailto:icds@psu.edu) to cancel.

# Converting MOAB (Roar) Submission Scripts to Slurm (Roar Collab)



The scheduler on Roar Collab, Slurm, uses submit files and commands that are structured similarly to those used by MOAB/Torque, the scheduler on the Roar cluster.

|To...|MOAB/Torque Command|Slurm Equivalent|
|--- |--- |--- |
|Submit a job|qsub|sbatch|
|Cancel a job|qdel|scancel|
|Check the status of a job|qstat|squeue|
|Check the status of all jobs by user|qstat –u|squeue –u|
|Hold a job|qhold|scontrol hold|
|Release a job|qrls|scontrol release|


|Resource request|MOAB/Torque Directive|Slurm Equivalent|
|--- |--- |--- |
|Script directive designator|#PBS|#SBATCH|
|Node Count|-l nodes=|-N or --nodes=|
|CPU count|-l ppn=|-n or --ntasks=|
|Wall time|-l walltime=|-t or --time=|
|Memory size|-l mem=|--mem= or --mem-per-cpu=|


For a more complete list of command and option comparisons, please see the [Slurm Rosetta Stone](https://slurm.schedmd.com/rosetta.pdf)


------
# Old Content below
  

#### 7.3 PBS Environmental Variables

Jobs submitted will automatically have several PBS environment variables created that can be used within the job submission script and scripts within the job. A full list of PBS environment variables can be used by viewing the output of

`env | grep PBS > log.pbsEnvVars`

run within a submitted job.

|Variable Name|Description|
|--- |--- |
|PBS_O_WORKDIR|The directory in which the qsub command was issued.|
|PBS_JOBID|The job's id.|
|PBS_JOBNAME|The job's name.|
|PBS_NODEFILE|A file in which all relevant node hostnames are stored for a job.|


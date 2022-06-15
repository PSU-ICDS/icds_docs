# Roar Collab User Guide



Roar Collab is the newest high performance research computing cluster managed by ICDS. Designed with collaboration in mind, the Roar Collab environment will allow for more frequent software updates and hardware upgrades to keep pace with researchers’ changing needs.

Still in its early stages, Roar Collab is currently only available “by invitation” so that we may ensure its limited resources not oversubscribed. As new resources are added, Roar Collab will become available to more users. [Learn more about our plans for expanding this resource here.](https://www.icds.psu.edu/computing-services/roar-collab/)

## Want to be an Early Adopter? Contact Us!

Given the limited compute resources now available, access to Roar Collab is currently by invitation only. Are you interested in being an early adopter of the new Roar Collab cluster? [Tell us a bit about your computing needs and we’ll be in touch.](https://www.icds.psu.edu/roar-collab-early-adopters/)



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



# File Storage on Roar Collab



There are several file storage options for users, each with their own quotas and retention policies. These are available for users to optimize for specific purposes.

Please note that while both Roar and Roar Collab have similar file storage locations. These are independent file systems and files cannot be accessed between clusters. Information on transferring files between Roar, Roar Collab, and Nearline storage can be found in [Transferring Data to and from Roar Collab](https://www.icds.psu.edu/how-to-transition-from-roar-to-roar-collab/).

|Storage|Location|Quota|Backup Policy|
|--- |--- |--- |--- |
|Home|/storage/home/|16 GB  
500,000 files|Daily snapshot|
|Work|/storage/work/|128 GB  
1 million files|Daily snapshot|
|Scratch|/scratch|No space quota  
1 million files|No backup  
Files purged after 30 days|
|Group|/storage/group/|Allocation dependent|No backup|

Group storage directories are created when an active storage allocation is established. If you are interested in setting up a storage or compute allocation, please contact us at [icds@psu.edu](mailto:icds@psu.edu) for more information.



# Submitting Jobs on Roar Collab



Roar Collab uses the [Slurm workload manager](https://slurm.schedmd.com/documentation.html) to manage job submission. Once a job is submitted, Slurm will match the job to available resources.

There are two primary methods of running jobs with Slurm – [interactively](https://www.icds.psu.edu/running-interactive-jobs-on-roar-collab/) or via [batch scheduling](https://www.icds.psu.edu/running-batch-jobs-on-roar-collab/). Both methods use [Slurm directives](https://www.icds.psu.edu/converting-moab-roar-submission-scripts-to-slurm-roar-collab/) to define required resources.



# Connecting to Roar Collab



Currently, Roar Collab resources are limited, so access is by invitation only. To request access, please contact us at [icds@psu.edu.](mailto:icds@psu.edu)   

Once an active account is created, users can connect using an SSH client at:

	submit.hpc.psu.edu

…or by using a browser to visit our web portal at [https://rcportal.hpc.psu.edu](https://rcportal.hpc.psu.edu/)



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


# Running Batch Jobs on Roar Collab 

To submit batch jobs, use the `sbatch` command to submit a job submit script to the scheduler. To highlight how this works, let’s use this basic script (called python.sh) as an example:

#!/bin/bash 
module load python/3.6 
python hello_world.py 

To submit this script as a batch job using the default parameters, the command would be:

$ sbatch python.sh 

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



# Running Interactive Jobs on Roar Collab



Interactive jobs allow a user to use compute resources while running commands and viewing output in real-time.

**Note:** To prevent performance issues for all users, intensive tasks such as code compilation and workflow troubleshooting should be done within interactive jobs.

To start an interactive job, use the “salloc” command. Using Slurm directives, job resource requirements can be customized. For example, to start a job over 4 cores and lasting 3 hours enter:

$ salloc -N 1 -n 4 --mem-per-cpu=1024 -t 3:00:00



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



# Using GPUs on Roar Collab



GPUs can be requested with the “- -gpu” directive. For example, to submit a job to run on a GPU enabled node, add the following line to the submit script:

#SBATCH --gpus=<n> 

Or specify the directive inline when using  “sbatch”:

$ sbatch --gpu=2 <submit_script> 



# Using a Paid Allocation on Roar Collab



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



# Managing Jobs on Roar Collab


To check the status of submitted jobs, use the “squeue” command. Using `squeue` without any options lists all pending and running jobs on the cluster. To see only the jobs submitted by a particular user id, add the following:

$ squeue -u <user_id> 



To cancel jobs, use `scancel`. To cancel a single job, specify the job id:

$ scancel <job_id> 



To cancel all jobs by a specific user, specify a user id:

$ scancel -u <user_id> 


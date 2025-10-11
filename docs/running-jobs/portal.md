# Portal

The Roar web [Portal][portal], powered by [Open OnDemand](https://openondemand.org/),
offers a visual desktop environment, file management, 
and Integrated Developer Environments (IDEs) such as Jupyter and RStudio.
[portal]: <https://portal.hpc.psu.edu>


## File Management

You can access files using the UI on the portal by going to the top bar: **Files** > **Your Storage Location** (e.g., `home`, `work`, `scratch`, or `group` directories).

## Interactive Jobs

You can run interactive jobs from the home page or by navigating via the top bar: **Interactive Apps** > **[Select the app you would like to run]**.

## Selecting resources

When launching an interactive app, you must specify the computational resources for your job. These options are typically selected using dropdowns and input fields on the application's launch page. The key resources you will need to define are:

* **Account:** The allocation or group that the job's usage will be billed against.
* **Queue:** The specific partition (a set of nodes) where your job will run. Different queues may offer different hardware (e.g., CPUs, GPUs) or have varying policies.
* **Number and Type of Nodes:** The quantity of machines your job will use and the specific type required (e.g., standard CPU or GPU-enabled node).
* **Number of Cores:** The total number of CPU cores to be allocated for your job.
* **Memory (RAM):** The amount of memory reserved for your job, usually specified in Gigabytes (GB).
* **Run Time:** The maximum duration your job is permitted to run (also known as "wall time"), typically in an HH:MM:SS format.

For the casual user, the default choices for these resources are sufficient:
1 node, 4 cores, 64GB, 1 hour, open queue. For other users, the limits for different types of allocations are as follows - 

- **Open queue** jobs must not exceed 100 cores and 800 GB memory
- **Interactive** jobs must not exceed 4 cores and 24 GB memory
- **Allocation** limits are defined by the terms of the allocation

To pay for your job with [credit account or allocation](../accounts/paying-for-compute.md),
select it from the Account drop-down menu.

With a credit account, you can choose a hardware [partition][partitions]
from the Partition drop-down menu to run your job.
With an allocation, select "sla-prio" from the Partition menu.
[partitions]: ../getting-started/compute-hardware.md#partitions

To override the default choices for nodes, cores, memory, and run time,
check the box "Enable advanced Slurm options",
and type Slurm [resource directives][slurmdir] one per line into the text box, like this:
[slurmdir]: slurm-scheduler.md#resource-directives
```
--ntasks=8
--mem=128GB
--time=8:00:00
```
The above requests 8 cores (tasks), 128GB memory, and 8 hour run time.

To request a GPU, you must be running on the standard partition, 
or have an allocation that includes GPUs.
The Slurm option to request one A40 GPU looks like:
```
--gres=gpu:a40:1
```

!!! warning "Hardware you request must be compatible with the account you specify."
	If you ask for high-memory nodes, standard nodes, or GPUs, 
	you need either a credit account, or a paid allocation 
	that includes the requested hardware.

Your selection in the **Account** dropdown determines which **Queue** (also called a partition) you can use:

 - Account: open
 - Sbatch options: --partition=open or select "Open" from the dropdown

To use an [allocation](../accounts/paying-for-compute.md):

 - Account: your_allocation_id
 - Sbatch options: --partition=sla-prio or select "sla-prio" from the dropdown

To specify a hardware partition for [credit accounts](../accounts/paying-for-compute.md):

 - Account: your_credit_account
 - Sbatch options: --partition=hardware_partition

For details regarding available hardware partitions, see [Available Hardware Partitions](../getting-started/compute-hardware.md/#partitions)

!!! warning "All jobs must fit inside the resource limits of the partition they are running on"
     If a job requests resources that exceed the partition limits, they will not begin.

## Custom environments

Jupyter and RStudio Server allow the use of custom software or environments. 
To use these, select "Use custom environment" under Environment type 
and enter commands to be run when the job launches.

For example, to use a custom Anaconda environment named `myenv`, 
the "Environment setup" box should contain:

```
module load anaconda
conda activate myenv
```

For more on using Anaconda environments in your Portal jobs, 
see [Anaconda on Portal](../packages/anaconda.md/#anaconda-on-portal).

# Portal

The Roar web [Portal][portal], powered by [Open OnDemand](https://openondemand.org/),
offers a visual desktop environment, file management, 
and Integrated Developer Environments (IDEs) such as Jupyter and RStudio.
[portal]: <https://portal.hpc.psu.edu>

## Selecting resources

Interactive jobs on the Portal use various resources:
queue, number and type of nodes, number of cores, memory (RAM), run time.
For the casual user, the default choices for these resources are sufficient:
1 node, 4 cores, 64GB, 1 hour, open queue.

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

 - Account: open
 - Sbatch options: --partition=open

To use an [allocation](../accounts/paying-for-compute.md):

 - Account: your_allocation_id
 - Sbatch options: --partition=sla-prio

To specify a hardware partition for [credit accounts](../accounts/paying-for-compute.md):

 - Account: your_credit_account
 - Sbatch options: --partiton=hardware_partition

For details regarding available hardware partitions, see [Available Hardware Partitions](../getting-started/compute-hardware.md/#partitions)

!!! warning "All jobs must fit inside the resource limits of the partition they are running on"
     If a job requests resources that exceed the partition limits, they will not begin.

- Open queue jobs must not exceed 100 cores and 800 GB memory
- Interactive jobs must not exceed 4 cores and 24 GB memory
- Allocation limits are defined by the terms of the allocation

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

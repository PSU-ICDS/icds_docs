# Using the Web Portal

ICDS offers an interactive web portal powered by [Open OnDemand](https://openondemand.org/)
which allows users access to graphical file handling features, graphical desktop software and
interfaces, and popular Integrated Developer Environments (IDEs) such as Jupyter Notebooks and RStudio.

To use the Web Portal, navigate to <https://portal.hpc.psu.edu>

For an in-depth overview of Open OnDemand features, see [this tutorial video](https://youtu.be/w1hbOppyUUc?si=Ubv0ymfeZmnD7Kzr)
developed by [The Yale Center for Research Computing](https://research.computing.yale.edu/)

## Selecting Resources for Interactive Jobs

Interactive jobs and scheduled and managed by Slurm and require resource definitions similar to
batch jobs. This means the amount of cores, memory (RAM), and run-time need to be specified before
jobs can be started.

Most of these can be specified using the drop down and number entry fields. However, it is possible to add 
more specialized resource requests by adding custom [directives](cli/slurm.md#slurm-resource-directives) by 
selecting "Enable advanced Slurm options" and entering the directives into the Sbatch options text box.

To avoid errors, the hardware requested must be accompanied by a compatable account, partition, and node type.
Here are some common use cases and the necessary settings:

To use the open partition:

 - Account: open
 - Sbatch options: --partition=open

To use an [allocation](paid-resources/allocations.md):

 - Account: your_allocation_id
 - Sbatch options: --partition=sla-prio

To specify a hardware partition for [credit accounts](paid-resources/credit-accounts.md):

 - Account: your_credit_account
 - Sbatch options: --partiton=hardware_partition

For details regarding available hardware partitions, see [Availalbe Hardware Partitions](paid-resources/credit-accounts.md/#available-hardware-partitions)

!!! warning "All jobs must fit inside the resource limits of the partition they are running on"
     If a job requests resources that exceed the partition limits, they will not begin.

- Open queue jobs must not exceed 100 cores and 800 GB memory
- Interactive jobs must not exceed 4 cores and 24 GB memory
- Paid resource limits are definied by the allocation limits

## Custom Environments

The Jupyter and RStudio Server Interactive Apps allow the use of custom software or environment options. 
To utilize these, select "Use custom environment" under Environment type and enter commands there to be ran 
once the job launches.

For example, to use a custom Anaconda environment named `myenv`, the following text should be included in 
the "Environment setup" box:

```
module load anaconda
conda activate myenv
```

For more details on using Anaconda environments within your Portal jobs, please see [Anaconda on 
Portal](../software/loading-packages/anaconda.md/#anaconda-on-portal).

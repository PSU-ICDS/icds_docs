# Portal

The Roar web [Portal][portal], powered by [Open OnDemand](https://openondemand.org/),
offers a visual desktop environment, file management, 
and Integrated Developer Environments (IDEs) such as Jupyter and RStudio.
[portal]: <https://portal.hpc.psu.edu>

## File management

You can access files using the UI on the portal by going to the top bar: **Files** > 
**Your Storage Location** (e.g., `home`, `work`, `scratch`, or `group` directories).

## Interactive jobs

You can run interactive jobs from the home page or by navigating via the top bar: 
**Interactive Apps** > **[Select the app you would like to run]**.

## Command Line Access

For advanced tasks, access to the command line interface is accessible two ways in the portal.

The first is by selecting "Clusters -> _RC Shell Access".

The second is inside an [Interactive Job](#interactive-jobs), such as the Persistant Terminal or 
[Interactive Desktop App](#interactive-desktop).

## Selecting resources

When launching an interactive app, you must specify the computational resources for your 
job. These options are typically selected using dropdowns and input fields on the 
application's launch page. The key resources you will need to define are:

* **Account:** The allocation or group that the job's usage will be billed against.
* **Partition:** The specific partition (a set of nodes) where your job will run. 
Different partitions may offer different hardware (e.g., CPUs, GPUs) or have varying policies.
* **Number and Type of Nodes:** The quantity of machines your job will use and the 
specific type required (e.g., standard CPU or GPU-enabled node).
* **Number of Cores:** The total number of CPU cores to be allocated for your job.
* **Memory (RAM):** The amount of memory reserved for your job, usually specified in Gigabytes (GB).
* **Run Time:** The maximum duration your job is permitted to run (also known as 
"wall time"), typically in an HH:MM:SS format.

### Advanced Slurm Options

Using Advanced Slurm options allows you to enter custom 
[Resource directives](./slurm-scheduler.md#resource-directives). These options allow you to fully 
customize your hardware allocation even allowing you to override the form restrictions 
for node and core count, memory, and runtime.

To do this, on a job submit form, ensure the "Enable advanced Slurm options" box is checked. 
This will cause the "Sbatch options" box to appear. Enter the desired [Resource directives](./slurm-scheduler.md#resource-directives) here.

For example, to request 8 cores (tasks), 128GB memory, and 8 hour run time - the Sbatch options box 
should contain:

```
--ntasks=8
--mem=128GB
--time=8:00:00
```
    
!!! warning "All jobs must fit inside the resource limits of the partition they are running on"
     If a job requests resources that exceed the partition limits, they will not begin.

### Requesting GPUs

To request a GPU with your interactive job, you will need to utilize [Advanced Slurm Options](#advanced-slurm-options) 
to enter the `--gres` directive specifying the number of and model of GPU needed.

See [Resource requests -> GPUs](resource-requests.md#gpus) for more information.

## Interactive Desktop

The Interactive Desktop provides a full graphical user interface (GUI) on a compute node. 
To launch a session, select **Interactive Apps > Interactive Desktop** from the top menu. 
For more details, see the [Open OnDemand documentation](https://openondemand.org/).

## Job composer

The Job Composer allows you to create and submit batch jobs directly from the web interface.

For more information, please see the 
[Open OnDemand documentation on the Job Composer](https://osc.github.io/ood-documentation/release-1.8/applications/job-composer.html).

## Using paid accounts

To run your job using a [credit account or allocation](../accounts/paid-resources.md),
select the relevant account ID from the Account drop-down menu. Then select a corresponding 
[partition](../system/system-overview.md#partitions).

 - Credit accounts need to use one of the hardware partitions: `basic`, `standard`, `himem`, or `interactive`
 - Allocations need to use the `sla-prio` partition 


## Using custom environments

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

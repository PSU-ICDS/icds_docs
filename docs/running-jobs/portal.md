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

### Selecting resources

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

!!! note "Advanced Slurm Options"
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
    
!!! warning "All jobs must fit inside the resource limits of the partition they are running on"
     If a job requests resources that exceed the partition limits, they will not begin.


#### Using paid accounts

To run your job using a [credit account or allocation](../accounts/paid-resources.md),
select the relevant account ID from the Account drop-down menu. Then select a corresponding 
[partition][../system/system-overview.md$#partitions].

 - Credit accounts need to use one of the hardware partitions: `basic`, `standard`, `himem`, or `interactive`
 - Allocations need to use the `sla-prio` partition 

#### Requesting GPUs

ICDS offers NVIDIA GPU resources. These are available for use with a credit account on the 
`standard` partition, or as part of a dedicated allocation.

To request access to a GPU within a job, the `--gres` directive is used. For example, to 
request 1 GPU as part of a job's resources:

```
--gres=gpu:1
```

This request will give you a single GPU of whatever type is available. To request a specific 
type of GPU, you must include the hardware attribute. For example, to request 1 A100 GPU:

```
--gres=gpu:a100:1
```

### Interactive desktop

The Interactive Desktop provides a full graphical user interface (GUI) on a compute node. 
To launch a session, select **Interactive Apps > Interactive Desktop** from the top menu. 
For more details, see the [Open OnDemand documentation](https://openondemand.org/).

## Job composer

The Job Composer allows you to create and submit batch jobs directly from the web interface.

For more information, please see the 
[Open OnDemand documentation on the Job Composer](https://osc.github.io/ood-documentation/release-1.8/applications/job-composer.html).


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

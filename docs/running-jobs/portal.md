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

### Interactive desktop

The Interactive Desktop provides a full graphical user interface (GUI) on a compute node. 
To launch a session, select **Interactive Apps > Interactive Desktop** from the top menu. 
For more details, see the [Open OnDemand documentation](https://openondemand.org/).

## Job composer

The Job Composer allows you to create and submit batch jobs directly from the web interface.

### Why use job composer?

Many users follow a common workflow:
1. Copy a previous job directory (their own or a colleague’s)
2. Edit a few input files
3. Submit the new job

### How it works

- **Templates** are pre-configured directories containing:
  - Job scripts (`.sh`, `.slurm`)
  - Input files (`.inp`, `.cfg`, etc.)
  - Example data
- You **start from a template** (or a past job), modify what you need, and submit — 
all via a web form.
- No need to manually copy files or edit scripts on the command line.

### Using the Job Composer

1. Log in to the [Roar Collab Portal](https://portal.hpc.psu.edu)
2. Navigate to **Interactive Apps > Job Composer**
3. Choose:
   - **New Job from Template** (start fresh)
   - **New Job from Existing Job** (copy a previous run)
4. Edit files in the browser
5. Click **Submit**

!!! tip 
	Ask your group to share useful templates — they appear under “Shared Templates” if permissions allow.

For more information, please see the [Open OnDemand documentation on the Job Composer](https://osc.github.io/ood-documentation/release-1.8/applications/job-composer.html).

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

For the casual user, the default choices for these resources are sufficient:
1 node, 4 cores, 64GB, 1 hour, open partition.

For other users, the limits for different types of allocations are as follows: 

- **Interactive** jobs must not exceed 4 cores and 64 GB memory
- **Allocation** limits are defined by the terms of the allocation

To pay for your job with [credit account or allocation](../accounts/paid-resources.md),
select it from the Account drop-down menu.

With a credit account, you can choose a hardware [partition][partitions]
from the Partition drop-down menu to run your job.
With an allocation, select "sla-prio" from the Partition menu.
[partitions]: ./resource-requests.md#partitions



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

Your selection in the **Account** dropdown determines which **Partition** you can use:

| | Open Partition | Credit | Allocation |
|---|---|---|---|
| **Account** | `open` | `credit_acct_id` | `allocation_acct_id` |
| **Partition(s)** | `open` <br> `interactive` | `basic` <br> `standard` <br> `himem` | `sla-prio` |

For details regarding available hardware partitions, see [Available Hardware Partitions](./resource-requests.md#partitions)

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

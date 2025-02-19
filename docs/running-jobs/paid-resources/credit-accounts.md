# Compute Credit Accounts

A credit account provides access to a variety compute resources for an individual user or for a group of users 
on a pay-per-use basis. 

A credit account provides the following benefits:

- Access to a variety of both CPU and GPU hardware resources
- Run times longer than the 48 hour limit on the open queue
- Pay only for the resources used

## Monitoring Credit Accounts

!!! warning "Credit use is non-refundable"
    There are no bounds on the maximum amount of credits jobs can use. Be judicious to avoid inadvertantly 
    using more credits than intended.

Submitting jobs against credit accounts will debit the account for resources allocated through the actual 
runtime of the job. The scheduler cannot differentiate between resources allocated versus resources actually used. 
When requesting multiple cores or GPU resources, ensure your job can utilize all of the requested hardware to 
avoid being charged for unused resources.


### Estimating Credit Use

The `job_estimate` utility can be used to determine how many credits would be used by a [batch 
job](../cli/batch-jobs.md) based on the resources requested in the [batch script](../cli/batch-jobs.md/#batch-scripts).

To use the utility, provide a batch script file as shown here:

```
job_estimate <submit file>
```

For example, if I have batch script called `comsol.slurm`, I can get an estimated credit use as follows:

```
$ job_estimate comsol.slurm
Estimated job cost: 0.0021 credits
```

The output units can be modified with the `--units` flag:

```
$ job_estimate --units slurm-billing-units comsol.slurm
Estimated job cost: 6000.0000 slurm-billing-units
```

For more options and details on their use, check `job-estimate --help`.


### Current balance information

The `get_balance` command can be used to show current credit account balances. To use, supply the credit account name:

```
get_balance <credit_account>
```

There are options for viewing the output in different units. Use `get_balance -h` for additional usage information.


## Available Hardware Partitions

Jobs submitted using a credit account can utilize a variety of the CPU and GPU resources in Roar Collab. 
Unlike an [allocation account](allocations.md), a credit account job must also specify the hardware it wants to utilize.

This is done by selecting a hardware partition to run on. Available options are:

- `basic`: Basic core resources (4 GB/core, Ethernet networking)
- `standard`: Standard core resources (8 GB/core, Infiniband connectivity)
- `himem`: High memory core resources (20 GB/core, Infiniband connectivity)

For CPU resources, credit accounts are charged based on the number of cores used and the runtime of the job. 
The number of cores equates to the number of requested cores, or their equivalent memory amount.

For example, if a job requests 1 core with 32 GB memory in the `standard` partition, it will be charged as if 4 
cores were used because it used the memory equivalent of 4 standard cores at 8 GB/core.


## Using a Credit Account on the Portal

To utilize a credit account on the Portal, select the desired account name under the "Account" drop down box in 
the Interactive Session request form.

If the account does not appear in the "Account" drop down box, you may need to be added to the allocation. Allocation 
coordinators can [add and remove users from their allocations](managing-accounts.md), or contact the helpdesk at
[icds@psu.edu] to request a user be added.

Additionally, a [hardware partition](#available-hardware-partitions) will need to be specified. To do so, select the 
"Enable advanced Slurm options" option and enter the necessary directives in the "Sbatch options" text box:

```
--partition=<desired_partition>
```

### Requesting GPUs

To request a GPU for a job, you will need to add the `--gres` directive to specify the desired hardware:

```
--partition=<desired_partition>
--gres=gpu:1
```

The number specified in `gpu:1` will indicate the total number of GPUs allocated for the job.

This can be further modified to request a specific GPU model:

```
--partition=<desired_partition>
--gres=gpu:a100:1
```

For more details on available GPU models, please see the current [Compute 
Hardware](../../getting-started/system-overview.md/#compute-hardware) available. 

!!! warning "Ensure your software is GPU enabled"
    Requesting GPU resources for a job is only beneficial if the software running within the job 
    is GPU-enabled 


#### VirtualGL GPU acceleration

The VirtualGL GPU acceleration option will ensure the job is launched using OpenGL. This option is beneficial if your 
interactive job uses a graphical interface and requires a GPU to use.

!!! warning "VirtualGL GPU acceleration requires a GPU"
     If you try to launch a job with the VirtualGL option enabled without requesting a GPU, the job will fail.


### Custom Hardware Configurations

Paid accounts can fine-tune their resource request using the `--constraint` directive.

To do so, select the "Enable advanced Slurm options" option and enter the necessary directives in the "Sbatch options" 
text box:

```
--constraint=<feature>
```

Any of the features listed in the AVAIL_FEATURES columnfrom the [sinfo output (above)](#sinfo) 
can be used as a constraint to customize your hardware requests. 

For example, to request a job only run on 
`cascadelake` hardware, you would add the following directive to your resource requests:
```
--constraint=cascakelake
```


## Using an Allocation on the Command Line

To submit a job using a credit account, supply the `--account` or `-A` resource directive with the credit account name, 
along with the desired hardware `--partition`.
 
Within a batch script that would look like:

```
#SBATCH --account=<compute_account>
#SBATCH --partition=<hardware_partition>
```

Or you can provide it as a flag to an `sbatch` command to submit a batch job:

```
sbatch -A <compute_account> -p <hardware_partition> <submit_script>
```

Or as a flag to an `salloc` command to request an interactive command line session:

```
salloc -A <compute_account> -p <hardware_partition>
```

### Custom Hardware Configurations

Paid accounts can fine-tune their resource request using the `--constraint` directive.

From within a submit script, the constraint feature can be used by adding the following to 
your SBATCH header:

```
#SBATCH --constraint=<feature>
```

where `<feature>` is one of the features listed by sinfo (or multiple features, separated by commas).

To request nodes with a given feature for an interactive job,  
add a `-C` option to your `salloc` command:

```
salloc -N 1 -n 4 -A <alloc> -C <feature> -t 1:00:00
```

Any of the "tags" listed in the AVAIL_FEATURES columnfrom the [sinfo output (above)](#sinfo) 
can be used as a constraint to customize your hardware requests. 

For example, to request a job only run on 
`cascadelake` hardware, you would add the following directive to your resource requests:
```
--constraint=cascakelake
```

### Requesting GPUs

All GPUs on Roar Collab available for credit accounts are hosted within the `standard` partition.

To request a GPU for a job running against a credit account, you will need to specify the `standard` partition and 
request GPUs with the `--gres=gpu:n` directive, where `n` is the number of GPU cards desired. Within a batch script, 
requesting one GPU card would look like:

```
#SBATCH --account=<credit_account_id>
#SBATCH --partition=standard
#SBATCH --gres=gpu:1
```

Or you can specify this along with your `sbatch` command when submitting jobs:

```
sbatch -A <credit_account_id> -p standard --gres=gpu:1 <batch_script>
```

For an interactive job, the `salloc` command is similar:
```
salloc -A <credit_account_id> -p standard --gres=gpu:1
```

This can be further modified to request a specific GPU model:

```
--partition=<desired_partition>
--gres=gpu:a100:1
```

For more details on available GPU models, please see the current [Compute 
Hardware](../../getting-started/compute-hardware.md) available. 

!!! warning "Ensure your software is GPU enabled"
    Requesting GPU resources for a job is only beneficial if the software running within the job 
    is GPU-enabled 


#### VirtualGL GPU acceleration

Using VirtualGL accelleration on the command line will ensure the job is launched using OpenGL. This option is 
beneficial if your interactive job uses a graphical interface and requires a GPU to use.

To run a command using VirtualGL accelleration, use the `vglrun` command. This command should be available on any 
GPU enabled node.

For example, running Amira3D using VirtualGL accelleration can be accomplished using the following command from a terminal 
prompt within an interactive job:

```
$ module load avizo
$ vglrun Amira3D
```

!!! warning "Graphical interfaces requires graphical support"
     To correctly launch a graphical interface requires an [X11 enabled SSH 
     connection](../../getting-started/connecting-to-rc.md/#x11-forwarding-x-window). Alternately, 
     an Interactive Desktop session on the [Roar Collab Portal](../portal.md) can be used instead. 

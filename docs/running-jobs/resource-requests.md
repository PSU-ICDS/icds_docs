# Resource requests 

Users with paid [credit accounts or allocations](../accounts/paid-resources.md)
can request GPU nodes, and fine-tune their hardware requests with `constraint` 
directives.

## GPUs

GPUs are only available to paid credit accounts,
or allocations that include GPU nodes.  

To request a single GPU:

```
--gres=gpu:1
```

To request n GPUs, replace 1 above by n.  

To request a specific model of GPU, use `--gres=gpu:a100:1`.

For an interactive job paid by a credit account, use `salloc`:
```
salloc -A <account> -p standard --gres=gpu:a100:1 ...
```

If the job is paid by an allocation, use `-p sla-prio` instead of `-p standard`.

For information on available GPU nodes and for the names of different GPU types (a100, a40, v100, p100,...)
see [Hardware info][hardwareinfo].
[hardwareinfo]: resource-requests.md/#hardware-info

!!! tip "Make sure your application is GPU-enabled."
    If your application does not use GPUs, requesting GPUs will do nothing 
    except deplete your accounts.  

!!! warning "Generic GPU requests (--gres=gpu:1) may allocate the most expensive GPU available"
    When you request a generic GPU with --gres=gpu:1, Slurm assigns any available GPU, 
    often the highest-cost model (e.g. A100) even if a cheaper one (e.g. P100) would suffice.
    This increases your costs unnecessarily if your job doesn’t require high-end hardware.

## Hardware info

To find out about hardware on different nodes, there are several options.

If you are logged onto a compute node with an [interactive job][salloc], 
the command `lscpu` displays information about the CPUs;
`nvidia-smi` displays information about the GPUs (if present).
[salloc]: interactive-jobs.md

Additionally, `sinfo` can be used to identify node attributes. Node attributes serve to identify nodes with a given:

- CPU type (icelake, haswell, ...)
- GPU type (a100, a40, v100, p100)
- partition (basic, standard, ...)
- unique hardware (a100_3g, ...)

See [System Overview](../system/system-overview.md) for more information.

## Constraints

Users with paid credit accounts and allocations can fine-tune their hardware requests 
with `constraint` directives.  In a batch script, constraints take the form:

```
#SBATCH --constraint=<feature>
```

where `<feature>` is one of the features listed by `sinfo`
(or multiple features, separated by commas). Please see sinfo output above to find various features that can be specified.
For example, to request `cascadelake` hardware, use `--constraint=cascadelake`.

For an [interactive job][salloc], constraints are given with a `--constraint` 
or `-C` option to `salloc`:

```
salloc -N 1 -n 4 -A <alloc> -C <feature> -t 1:00:00
```

!!! warning "Resource requests must match the allocation."
    For paid allocations, constraint directives
    must be consistent with the terms of the allocation.
    For credit accounts, any hardware in the credit partitions 
    can be requested.


## Optimizing usage

For credit accounts, it is helpful to estimate how many credits a batch job would use before you actually run it. For this, use `job_estimate`:

```bash
job_estimate <submit file>
```

### Selecting nodes, cores, and memory

Choosing the right resources is critical for efficiency.

*   **Nodes and Cores**: Most software is multi-threaded (runs on one computer, multiple cores). Set `--nodes=1` and `--ntasks` to the number of cores needed. Only request multiple nodes if your software uses MPI for distributed computing.
*   **Memory**: Requesting too little memory causes failure; too much wastes resources. Start by estimating your data size and add a 20% buffer.

#### Timing and efficiency

Test new workflows with short jobs before submitting long ones. You can time jobs using the `time` command or `date` commands in your script.

To check the efficiency of a completed job, use the `seff` command:

```bash
seff <jobid>
```

This will report the CPU and memory efficiency, helping you adjust future requests.

You can also use `sacct` for detailed resource usage:

```bash
sacct -j $SLURM_JOB_ID --format=JobID,JobName,MaxRSS,Elapsed,TotalCPU,State
```


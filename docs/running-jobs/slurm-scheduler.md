
# Slurm scheduler

Roar is a shared system used by many researchers and uses [Slurm](https://slurm.schedmd.com) (Simple Linux Utility for Resource Management) for scheduling. The Slurm scheduler is the cluster's essential resource manager, responsible for fairly and efficiently distributing compute resources (like CPUs, memory, and GPUs) to all users. It acts as the system's workload manager, preventing conflicts and ensuring orderly access to the hardware.

When you submit a job, you specify the resources you need. Slurm then performs several key function like job Queueing, Resource Allocation, Policy Enforcement, execution and monitoring.

## Resource directives

Resource directives specify resources needed by a job,
including the hardware to use (nodes, cores, GPUs, memory) and the run time.
They are required for both [interactive jobs](interactive-jobs.md) 
and [batch jobs](batch-jobs.md).
Interactive jobs via the [Portal](portal.md) can also use resource directives.

The most common directives are:

| Short option | Long option | Description |
| ---- | ---- | ---- |
| `-J` | `--job-name` | name the job |
| `-A` | `--account` | charge to an account |
| `-p` | `--partition` | request a partition |
| `-N` | `--nodes` | number of nodes |
| `-n` | `--ntasks` | number of tasks (cores) |
| NA | `--ntasks-per-node` | number of tasks per node |
| NA | `--mem` | memory per node |
| NA | `--mem-per-cpu` | memory per core |
| `-t` | `--time` | maximum run time |
| NA | `--gres` | GPU request |
| `-C` | `--constraint` | required node features<br>*only for paid accounts* |
| `-e` | `--error` | direct standard error to a file |
| `-o` | `--output` | direct standard output to a file |

You provide these directives at the top of a batch script using #SBATCH, or as options on the command line (e.g., with salloc or srun). Please check out our examples job repository on Github to find ready-to-run examples using slurm directives - 

[ICDS Github Job Examples For Roar Collab](https://github.com/PSU-ICDS/rc-example-jobs)

!!! warning "Note on Tasks vs. Cores"
     For most jobs, you can think of one **task** as one **CPU core**. So, `--ntasks=8` requests 8 cores.

!!! warning "Note on Memory" 
    Be careful when requesting memory!
    
    `--mem=16G` requests 16 GB of memory **for the entire node**.
    
    `--mem-per-cpu=4G` requests 4 GB of memory **for each core** you've requested. If you requested 4 cores, this would total 16 GB.

## Environment variables

Slurm defines environment variables within the scope of a job:

| Environment Variable | Description |
| ---- | ---- |
| `SLURM_JOB_ID` | ID of the job |
| `SLURM_JOB_NAME` | Name of job |
| `SLURM_NNODES` | Number of nodes |
| `SLURM_NODELIST` | List of nodes |
| `SLURM_NTASKS` | Total number of tasks |
| `SLURM_NTASKS_PER_NODE` | Number of tasks per node |
| `SLURM_QUEUE` | Queue (partition) |
| `SLURM_SUBMIT_DIR` | Directory of job submission |

## Replacement symbols

Replacement symbols can be used in Slurm directives,
to build job names and filenames with information specific to the job being run:

| Symbol | Description |
| :----: | ---- |
| `%j` | Job ID |
| `%x` | Job name |
| `%u` | Username |
| `%N` | Hostname where the job is running |


For more information on Slurm directives, environment variables, and replacement symbols, 
see [Slurm sbatch documentation](https://slurm.schedmd.com/sbatch.html) for batch jobs 
and [Slurm salloc documentation](https://slurm.schedmd.com/salloc.html) for interactive jobs.

## Job output files

By default, batch job standard output and standard error
are both directed to `slurm-%j.out`, where `%j` is the jobID.
But output and error filenames can be customized:
`#SBATCH -e = <file>` redirects standard error to `<file>`,
and ` #SBATCH -o` likewise redirects standard output.

SLURM variables `%x` (job name) and `%u` (username)
are useful for this purpose. It's a good practice to name your output files to keep your directory organized. 
For example,

| Symbol | Replaces With | Example |
| :----: | ------------- | ------- |
| `%j`   | Job ID        | `34292` |
| `%x`   | Job Name      | `my_first_job` |
| `%u`   | Your Username | `xyz123` |

To save the standard output to `my_first_job-34292.out` and the standard error to `my_first_job-34292.err`, you would add these lines to your script:
```bash
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
```




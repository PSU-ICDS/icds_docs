
# Slurm scheduler

Roar is a shared system used by many researchers and uses [Slurm](https://slurm.schedmd.com)
for scheduling. The Slurm scheduler is the cluster's essential resource manager, 
responsible for fairly and efficiently distributing compute resources (like CPUs, memory, 
and GPUs) to all users. It acts as the system's workload manager, preventing conflicts 
 and ensuring orderly access to the hardware.

When you submit a job, you specify the resources you need. Slurm then performs several key 
function like job queueing, resource allocation, policy enforcement, execution and monitoring.

## Resource directives

Resource directives are used to specify how a job behaves and the resources to be allocated. 
directives can be used to define resources such as cores memory, and time needed. But they 
can also be used to set job options such as email alerts, job dependencies, and more.

They are required for all jobs including both [interactive jobs](interactive-jobs.md) 
and [batch jobs](batch-jobs.md).

Interactive jobs via the [Portal](portal.md) also use resource directives, though they are 
often specified through the request forms.

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
| `-C` | `--constraint` | required node features|
| `-e` | `--error` | direct standard error to a file |
| `-o` | `--output` | direct standard output to a file |

!!! tip "Custom output file names"
    By default, batch job standard output and standard error are both directed to 
    `slurm-%j.out`(where `%j` is the jobID). But output and error filenames can be 
     customized by using `--output=filename` to redirect output to a specified file.
     If only `--output` is specified, both standard output and error will be directed to 
     the file. specifying `--error=filename` will direct standard error to its own file.


### Specifying resource directives

You provide these directives at the top of a batch script using #SBATCH, or as options on 
the command line (e.g., with salloc or srun). 

On the portal, you can use resource directives to further customize your job requests.

!!! warning "Note on Tasks vs. Cores"
     For most jobs, you can think of one **task** as one **CPU core**. So, `--ntasks=8` 
     requests 8 cores.

!!! warning "Note on Memory" 
    Be careful when requesting memory!
    
    `--mem=16G` requests 16 GB of memory **for the entire node**.
    
    `--mem-per-cpu=4G` requests 4 GB of memory **for each core** you've requested. If you 
    requested 4 cores, this would total 16 GB.

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

These can be used in your submit script to make them more dynamic to the resources allocated.

!!! tip "Use $SLURM_NTASKS for parallel jobs"
    Using `$SLURM_NTASKS` to specify the number of parallel tasks in your submit script 
    allows your job to dynamically adapt to the jobs resource request without having to 
    modify your script in multiple locations.

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

!!! tip "Replacement symbols to create unique output files"
    Using replacement symbols in your resource requests can be used to create unique output 
    file names for each run of a job. For example `--output=myjob.%j.out` will create a 
    different output file for each job using the Slurm Job ID to replace `%j`



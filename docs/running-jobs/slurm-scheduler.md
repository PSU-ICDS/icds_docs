
# Slurm scheduler

Roar uses [Slurm](https://slurm.schedmd.com) (Simple Linux Utility for Resource Management)
to schedule submitted jobs and allocate compute resources. 


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
are useful for this purpose.  For example,
```
#SBATCH -eo = %u_%x.out
```
writes both standard output and error to `<username>_<jobname>.out`.




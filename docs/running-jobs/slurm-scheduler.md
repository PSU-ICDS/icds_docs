
# Slurm scheduler

Roar uses [Slurm](https://slurm.schedmd.com) to fairly and efficiently distribute resources 
(CPUs, memory, and GPUs) among many different compute jobs.

## Slurm directives

Slurm directives are used to specify the resources a job needs,
such as cores, memory, and execution time.
The can also be used to control how a job behaves,
with options such as email alerts, job dependencies, and more.

Slurm directives are required for both [interactive jobs](interactive-jobs.md) 
and [batch jobs](batch-jobs.md).
[Portal](portal.md) sessions also use Slurm directives, 
which are typically specified via the request form that launches the session.

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

By default, standard output and standard error are both directed to `slurm-<jobID>.out`. <br>
Output filenames can be customized: `--output=<outFile>` 
directs standard error and output to ``<outFile>``;
adding `--error=<errFile>` directs standard error to its own file `<errFile>`.

### Specifying Slurm directives

Slurm directives appear at the top of a [batch script](batch-jobs.md) using ``#SBATCH``, 
or as options for [interactive jobs](interactive-jobs.md) launched with `salloc` or `srun`. 

On the Portal, you can use resource directives to further customize your job requests.

## Environment variables

Slurm defines environment variables for jobs, which can be accessed in batch scripts
to make them respond more flexibly:

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
to customize filenames with information specific to the job being run:

| Symbol | Description |
| :----: | ---- |
| `%j` | Job ID |
| `%x` | Job name |
| `%u` | Username |
| `%N` | Hostname where the job is running |

For example, `--output=%x.%j.out` directs batch output to a file
named with the job name and jobID.

For more information on Slurm directives, environment variables, and replacement symbols, 
see [Slurm sbatch documentation](https://slurm.schedmd.com/sbatch.html) for batch jobs 
and [Slurm salloc documentation](https://slurm.schedmd.com/salloc.html) for interactive jobs.



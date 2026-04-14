# How To: Fix a Script That Works Interactively but Fails in a Batch Job

Use this guide when a Python, R, or shell script runs correctly in an interactive session (terminal, Portal, or `salloc`) but fails when submitted as a batch job with `sbatch`.

This mismatch almost always comes down to environment differences: your interactive session has modules loaded, paths set, and a working directory that your batch job does not.

---

## Step 1: Check the error log

Find your Slurm error log (by default `slurm-JOBID.out`, or whatever file you set with `--error`):

```bash
cat slurm-YOUR_JOB_ID.out
```

Common error messages and their causes are addressed in the steps below.

---

## Step 2: Add missing `module load` commands

Batch jobs start with a clean environment — no modules are loaded. If your script uses Python, R, or any other software from the module system, it must load those modules explicitly.

Add `module purge` and all required `module load` commands near the top of your script, **after** the last `#SBATCH` line:

```bash
#!/bin/bash
#SBATCH --account=account_id
#SBATCH --partition=basic
#SBATCH --ntasks=4
#SBATCH --mem=8G
#SBATCH --time=2:00:00

module purge
module load python/3.11.2

python3 myscript.py
```

To find out which modules you had loaded during a working interactive session, run:

```bash
module list
```

---

## Step 3: Fix relative and hardcoded paths

Batch jobs run with a working directory equal to the directory from which you ran `sbatch`. If your script references files with relative paths (e.g., `./data/input.csv`), those paths are resolved relative to that directory.

Check for:

- **Relative paths** that assume a specific working directory
- **Hardcoded absolute paths** that point to locations outside your storage directories

Fix by using absolute paths with environment variables:

```bash
python3 $HOME/project/myscript.py --input $WORK/data/input.csv
```

Or, add a `cd` at the top of your script to set the working directory explicitly:

```bash
cd $HOME/project
python3 myscript.py
```

---

## Step 4: Check for conda environments

If you use a conda environment, it must be activated explicitly in the batch script. A conda environment that is active in your interactive session is **not** carried into a batch job.

```bash
module load anaconda
conda activate myenv

python3 myscript.py
```

!!! note "Activate on compute nodes only"
    Anaconda processes running on submit nodes are often killed. If you are testing interactively, use `salloc` to get a compute node first, or use a Portal interactive session.

---

## Step 5: Check for missing environment variables

Some scripts rely on environment variables (API keys, custom library paths, etc.) that you set in your shell profile or manually in an interactive session. Batch jobs do not inherit these.

Set any required variables explicitly in your script:

```bash
export MY_DATA_DIR=$WORK/datasets
```

---

## Step 6: Test in a minimal interactive job

If the error is still unclear, reproduce it in an interactive compute session where you can investigate in real time:

```bash
salloc --nodes=1 --ntasks=4 --mem=8G --partition=standard --account=<account> --time=01:00:00
```

Once on the compute node, reproduce the environment from your batch script step by step:

```bash
module purge
module load python/3.11.2
cd $HOME/project
python3 myscript.py
```

This helps isolate exactly which step is failing.

---

## Additional resources

- [Batch jobs](../../running-jobs/batch-jobs.md)
- [Interactive jobs](../../running-jobs/interactive-jobs.md)
- [Using modules](../../software/modules.md)
- [Anaconda](../../packages/anaconda.md)
- [Contact ICDS support](../getting-help.md)

# How To: Fix an Out of Memory Job Failure

Use this guide when your job has been terminated by Slurm with an "Out of Memory" (OOM) error. This happens when a job uses more RAM than was requested, and Slurm kills it to protect the node and other users.

---

## Step 1: Find the peak memory your job used

Run `sacct` with your failed job ID to see how much memory the job actually consumed:

```bash
sacct -j YOUR_JOB_ID --format=MaxRSS,ReqMem
```

- `MaxRSS` — the peak memory the job used (in kilobytes by default)
- `ReqMem` — the memory you originally requested

Note the `MaxRSS` value. This is the minimum memory your job needs.

---

## Step 2: Calculate a safe memory request

Add a 10–20% buffer to the `MaxRSS` value to account for variation between runs.

For example, if `MaxRSS` was `8000000K` (~8 GB), request at least `10G`.

---

## Step 3: Update your batch script

Open your job script and increase the memory directive:

```bash
#SBATCH --mem=10G
```

Or, if you are using per-CPU memory:

```bash
#SBATCH --mem-per-cpu=5G
```

---

## Step 4: Resubmit your job

```bash
sbatch your_job_script.sh
```

Monitor the job with `squeue --me` to confirm it starts and runs to completion.

---

## Tips

- If `sacct` shows no output, the job may have been too short-lived. Try using `seff YOUR_JOB_ID` if available, or check the job's output/error logs.
- If your job's memory usage varies widely between runs, request memory based on the largest expected input.
- See [Resource Requests](../../running-jobs/resource-requests.md) for guidance on memory and other Slurm directives.

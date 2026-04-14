# How To: Handle a Job That Ran Out of Time

Use this guide when your job was cancelled by Slurm because it exceeded its requested time limit. The job will appear in `sacct` with a state of `TIMEOUT` or `CANCELLED`.

---

## Step 1: Confirm the job timed out

Check the exit state of your job:

```bash
sacct -j YOUR_JOB_ID --format=JobID,JobName,State,Elapsed,Timelimit
```

- `State` — look for `TIMEOUT` or `CANCELLED by 0`
- `Elapsed` — how long the job actually ran
- `Timelimit` — the limit you requested

If `Elapsed` equals `Timelimit`, the job was killed at the wall-clock limit.

---

## Step 2: Estimate how much time the job needs

Compare `Elapsed` against `Timelimit` to decide how much more time to add. A few strategies:

- **Small overage**: if `Elapsed` was close to `Timelimit`, increase by 25–50%.
- **Unknown runtime**: run a short test with a subset of your input data, time it with `time`, and scale up.
- **Reproducible benchmark**: add `date` commands around the main work in your script to capture timestamps in the output log.

```bash
date
your_main_command
date
```

---

## Step 3: Update the time request in your batch script

Open your job script and increase the `--time` directive. The format is `D-HH:MM:SS`:

```bash
#SBATCH --time=12:00:00
```

!!! warning "Time limits vary by partition"
    Each partition has a maximum wall-clock time. If your job needs more than a day, confirm the limit for your partition in the [System Overview](../../system/system-overview.md) before requesting it.

---

## Step 4: Resubmit your job

```bash
sbatch your_job_script.sh
```

Monitor with `squeue --me` to confirm the job starts and reaches completion.

---

## Tips

- If your job consistently needs more than 48 hours, consider breaking the work into smaller stages that save intermediate results to disk and resume from a checkpoint.
- Use `seff YOUR_JOB_ID` after a successful run to review CPU and memory efficiency alongside elapsed time.
- See [Resource Requests](../../running-jobs/resource-requests.md) for guidance on partition limits and other Slurm directives.

## Additional resources

- [Resource requests reference](../../running-jobs/resource-requests.md)
- [Batch jobs](../../running-jobs/batch-jobs.md)
- [Contact ICDS support](../getting-help.md)

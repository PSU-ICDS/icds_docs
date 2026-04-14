# How To: Diagnose a Job That Produced No Output

Use this guide when a batch job completed (or appeared to complete) but did not produce the output files you expected, or when no output or error log was created.

---

## Step 1: Confirm the job ran and check its exit status

Look up your job in the Slurm accounting database:

```bash
sacct -j YOUR_JOB_ID --format=JobID,JobName,State,ExitCode,Elapsed
```

- `State` — `COMPLETED` means Slurm considers the job finished; `FAILED` means it exited with an error
- `ExitCode` — `0:0` is a clean exit; any non-zero value indicates the job or a step within it failed

If the job shows `FAILED` with a non-zero exit code, check for error messages in the next step.

---

## Step 2: Find your output and error logs

By default, Slurm writes all output (stdout and stderr combined) to a file named `slurm-JOBID.out` in the directory where you ran `sbatch`. Look for that file:

```bash
ls slurm-*.out
```

If you specified custom log files in your script, look for those instead:

```bash
#SBATCH --output=job_%j.out
#SBATCH --error=job_%j.err
```

If no log file exists at all, your job may have failed before Slurm could create one — usually due to a problem in the script preamble (bad `#SBATCH` directive, missing account, etc.).

---

## Step 3: Read the log file for errors

```bash
cat slurm-YOUR_JOB_ID.out
```

Look for:

- Python tracebacks, R error messages, or application-specific errors
- Lines containing `Error`, `error`, `command not found`, `No such file or directory`
- An abrupt end with no final output — this can indicate the job was killed (OOM, timeout) rather than finishing normally

---

## Step 4: Act on what the log shows

### "Command not found" or "No such file or directory"

A module was not loaded, or a path is wrong. See [My script works interactively but fails in a batch job](script-fails-in-batch.md) for a step-by-step fix.

### The log file is empty

The script may have exited silently on the first command. Add `set -e` and `set -x` near the top of your script to make bash exit on error and print each command before running it:

```bash
#!/bin/bash
set -e
set -x
#SBATCH ...
```

Resubmit and re-examine the log.

### No log file was created at all

Check whether the job was ever accepted by Slurm:

```bash
sacct -u $USER --starttime=today --format=JobID,JobName,State,Submit
```

If the job is absent, `sbatch` may have rejected it silently. Re-run `sbatch` interactively and read any error message it prints.

### The job completed but output files are missing

Your script may be writing to a different directory than you expect. Check for hardcoded paths and relative paths. Output written to `$SCRATCH` may have been purged if older than 30 days.

---

## Step 5: Add explicit output and error directives for the future

Add these lines to your batch scripts to keep stdout and stderr in separate, clearly named files:

```bash
#SBATCH --output=job_%j.out
#SBATCH --error=job_%j.err
```

`%j` is replaced by the job ID, making each run's logs easy to find.

---

## Additional resources

- [Batch jobs](../../running-jobs/batch-jobs.md)
- [How to fix an Out of Memory job failure](out-of-memory-error.md)
- [How to handle a job that ran out of time](job-timed-out.md)
- [Contact ICDS support](../getting-help.md)

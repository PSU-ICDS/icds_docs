# How To: Help Support Reproduce a Long-Running Job Failure

Use this guide when your job fails after running for hours or days and you need to report it to ICDS support. Providing a minimal reproducible example dramatically speeds up diagnosis and resolution.

---

## Step 1: Reduce the input size

Scale down whatever data or parameters your job uses so the problem appears quickly:

- Use a **smaller dataset** — a subset of rows, a coarser grid, or fewer iterations
- Reduce the **time to failure** — aim for seconds or minutes instead of hours
- Request **fewer resources** — fewer cores, nodes, or less memory

The goal is a job that fails in a way support can reproduce in a short test run.

---

## Step 2: Confirm the failure still occurs

Run the scaled-down version to verify it still triggers the same error:

```bash
sbatch your_minimal_job_script.sh
```

Check the output and error logs to confirm the failure mode matches the original problem.

!!! note
    Often, reducing the problem reveals the underlying cause immediately. If the minimal version runs successfully, the issue may be related to scale (memory, runtime, data size), which is itself useful information for support.

---

## Step 3: Gather the details to report

Collect the following before contacting support:

- The job ID of both the failed original job and the minimal reproduction
- Your batch script (`your_minimal_job_script.sh`)
- The relevant lines from your output and error logs
- The module(s) or software version(s) you are using
- A brief description of what the job does and where it fails

---

## Step 4: Contact ICDS support

Submit your report with the information above to the [ICDS Help Desk](../getting-help.md). The more clearly you can describe the failure and the steps to reproduce it, the faster support can identify and fix the issue.

# How To: Schedule a Recurring Batch Job with scrontab

Use this guide to set up a batch job that runs automatically on a recurring schedule — for example, every night, every Monday morning, or on the first of each month. Roar uses `scrontab`, a Slurm utility that works like the standard Unix `crontab` but submits jobs through the Slurm scheduler.

---

## Step 1: Write and test your batch script

Before scheduling a job, make sure it runs correctly as a one-time submission:

```bash
sbatch your_job_script.sh
```

Confirm the job completes successfully and produces the expected output. A recurring job that silently fails can be difficult to catch.

Make a note of the **absolute path** to your script. `scrontab` requires absolute paths.

---

## Step 2: Open your scrontab for editing

```bash
scrontab -e
```

This opens a text editor (usually `vi` or `nano`, depending on your `$EDITOR` setting). If you prefer a specific editor:

```bash
EDITOR=nano scrontab -e
```

---

## Step 3: Add a scheduled job entry

Each line in a scrontab file schedules one job. The format is:

```
<minute> <hour> <day_of_month> <month> <day_of_week> <slurm_options> <script_path>
```

The time fields follow standard crontab syntax:

| Field | Range | Meaning |
| ---- | ---- | ---- |
| minute | 0–59 | Minute of the hour |
| hour | 0–23 | Hour of the day (24-hour) |
| day_of_month | 1–31 | Day of the month |
| month | 1–12 | Month of the year |
| day_of_week | 0–6 | Day of the week (0 = Sunday) |

Use `*` to match any value.

### Examples

Run every day at 2:30 AM:

```
30 2 * * * --account=account_id --partition=basic /storage/home/abc123/jobs/nightly.sh
```

Run every Monday at 8:00 AM:

```
0 8 * * 1 --account=account_id --partition=basic /storage/home/abc123/jobs/weekly.sh
```

Run on the first of every month at midnight:

```
0 0 1 * * --account=account_id --partition=standard --mem=16G --time=4:00:00 /storage/home/abc123/jobs/monthly.sh
```

!!! note "Use absolute paths"
    `scrontab` does not expand `$HOME` or other environment variables in the script path. Use the full path (e.g., `/storage/home/abc123/`) rather than `$HOME`.

---

## Step 4: Save and exit

Save the file and exit the editor. Slurm will confirm the schedule was updated.

---

## Step 5: Verify your schedule

List your current scrontab to confirm it was saved correctly:

```bash
scrontab -l
```

---

## Managing your scrontab

| Command | Effect |
| ---- | ---- |
| `scrontab -e` | Edit the current schedule |
| `scrontab -l` | List the current schedule |
| `scrontab -r` | Remove all scheduled jobs |

To remove a single scheduled job without removing others, open the editor with `scrontab -e` and delete that line.

---

## Tips

- Scheduled jobs are submitted to the Slurm queue like any other batch job; they will wait for resources if the cluster is busy.
- Include `--output` and `--error` directives in the Slurm options (or in the script itself) so each run's logs are saved with a timestamp or job ID.
- Jobs that are still running when the next scheduled run starts will overlap. If your job may run longer than the schedule interval, add logic to your script to detect and skip a run if a previous one is still in progress.

## Additional resources

- [Batch jobs](../../running-jobs/batch-jobs.md)
- [Resource requests reference](../../running-jobs/resource-requests.md)
- [Slurm scrontab documentation](https://slurm.schedmd.com/scrontab.html)
- [Contact ICDS support](../getting-help.md)

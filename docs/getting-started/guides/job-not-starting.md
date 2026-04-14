# How To: Diagnose a Job That Won't Start

Use this guide when your job's status in `squeue` shows `PD` (Pending) and the job has not started after an expected wait.

---

## Step 1: Check your job status and reason

Run the following command to see all of your pending jobs and the reason each one is waiting:

```bash
squeue --me
```

Look at the `NODELIST(REASON)` column. The reason code tells you what to do next.

---

## Step 2: Check the estimated start time

```bash
squeue --me --start
```

This shows the worst-case estimated start time for each pending job. Use this to decide whether to wait or adjust your submission.

---

## Step 3: Act based on the reason code

### `(Resources)`

The cluster is busy and all nodes that can fulfill your request are in use. **Wait** for resources to free up. No action is needed.

### `(Priority)`

Your job is queued behind higher-priority jobs. Your priority increases over time. **Wait.**

### `(QOSMax---PerUserLimit)`

You have reached the maximum number of cores, nodes, memory, or jobs allowed simultaneously in your QoS. **Wait** for some of your running jobs to finish before this one can start.

### `(AssocGrpBillingMinutes)`

Your credit account does not have enough balance to run this job.

1. Check whether any currently running jobs will finish soon—your job may launch if credits free up.
2. If credits are insufficient, [contact ICDS](../getting-help.md) to purchase additional credits.

### `(ReqNodeNotAvail)`

No available hardware matches your resource request. Either the configuration does not exist, or matching nodes are currently down.

1. Review your `--partition`, `--mem`, `--cpus-per-task`, and `--gres` (GPU) values.
2. Compare them against the available hardware in the [System Overview](../../system/system-overview.md).
3. Correct any invalid values and resubmit.

### `(Reserved for maintenance)`

Your job is not expected to finish before a scheduled outage, so it has been held until after the maintenance window ends. **Wait** for the outage to pass.

---

## Additional resources

- Video: [Debugging Portal Job Issues](https://psu.mediaspace.kaltura.com/media/Tuesday+Tips+October/1_ph23usu3)
- [Resource requests reference](../../running-jobs/resource-requests.md)
- [Contact ICDS support](../getting-help.md)

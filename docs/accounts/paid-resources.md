# Paid resources

All users are automatically provided a fixed number of [free credits](read-credits.md) each month. 
Beyond this level, ICDS offers paid compute in the form of credits and allocations. 

All users are also provided some file storage space in `work` and `home`.
ICDS also offers paid group storage mounted on the cluster, and paid archive storage.

## Compute offerings

**Credit accounts** are like Starbucks cards:  

- you only pay for what you use; 
- you can buy time on any type of hardware you need;
- but you must stand in line with other paying customers.

**Allocations** are like vacation time-shares:  

- you reserve time on specific hardware;
- you get prompt access to your resources; 
- but you cannot use hardware different from what you reserved,
- and you must pay whether or not you use the time.

With both credit accounts and allocations, 
PIs can manage the account, adding group members to the list of allowed users.

PIs can have multiple accounts and allocations, with different user lists, 
paid by different sources of funds, for different research projects.

## Using credit accounts and allocations

All credit accounts and allocations have names.
A user's free credit account is named `open`;
the default name for a paid credit account is `<userID>_cr_default`.

When [Portal sessions](../running-jobs/portal.md),
[interactive jobs](../running-jobs/interactive-jobs.md),
or [batch jobs](../running-jobs/batch-jobs.md) are paid for,
the account or allocation name is given,
and the corresponding account or allocation charged.

## Storage offerings

Paid storage is available as group or archive storage.

**Group storage** is shared storage that is mounted on the cluster. 
This storage is intended for use with compute jobs 
and can be shared with a specified group of users.

Group storage membership can be managed
by requesting that members be added (via email, to <icds@psu.edu>),
or by setting up a [User Managed Group](managing-storage.md).

**Archive storage** is intended for long-term file retention.
Files in archive storage must be transferred to the cluster
before they can be accessed or modified.

## Prices

Prices for different nodes are set proportional to the cost of the hardware,
and competitive with the cost of buying your own cluster.
More expensive nodes cost more to use, reflecting their greater value.

To purchase credits or allocations, read the [current pricing and details][prices] 
or contact us at <icds@psu.edu>.[prices]: https://icds.psu.edu/services/roar/details-rates/

## Estimating job costs

It is helpful to estimate how many credits a batch job would use 
before you run it. 

For jobs that have not yet been run,
use `job_estimate <batchFile>` from the command line.

From the [Portal](https://portal.hpc.psu.edu/),
ineractively scheduled jobs display a cost estimate near the Launch button,
which updates as you adjust requested resources, partitions, and job duration.


### Past job costs

For one or more jobs that have already been run,
the cost to run them again can be computed with `credit_estimate`.

For a single job ID, use `credit_estimate -j <jobID>`;
for a list of job IDs, use `credit_estimate -l <jobID_list_file>`.

Lists of job IDs can be genertaed with `sacct`.
These can be piped directly to `credit_estimate`:

```
sacct -n -X -o jobid -u $USER -S 1/1 | credit_estimate
```

For more information, use `credit_estimate -h`.

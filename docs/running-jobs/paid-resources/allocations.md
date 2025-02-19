# Compute Allocations

A paid compute allocation provides access to specific compute resources for an individual user or for a group of users. 

A paid compute allocation provides the following benefits:

- Immediate job start for resources up to the allocation limits
- Run times longer than the 48 hour limit on the open queue
- No preemption

## Using an Allocation on the Portal

To utilize an allocation on the Portal, select the desired account name under the "Account" drop down box in 
the Interactive Session request form.

If the account does not appear in the "Account" drop down box, you may need to be added to the allocation. Allocation 
coordinators can [add and remove users from their allocations](managing-accounts.md), or contact the helpdesk at
(icds@psu.edu) to request a user be added.


## Using an Allocation on the Command Line

To submit a job to a paid compute account, supply the `--account` or `-A` resource directive with the compute account name. 
Within a batch script that would look like:

```
#SBATCH -A <compute_account>
```

Or you can provide it as a flag to an `sbatch` command to submit a batch job:

```
sbatch -A <compute_account> <submit_script>
```

Or as a flag to an `salloc` command to request an interactive command line session:

```
salloc -A <compute_account>
```

## Monitoring Allocation Access

The `mybalance` command on Roar lists accessible compute accounts and resource information associated with those compute accounts. 

Use the `mybalance -h` option for additional usage information.

If the account does not appear in the `mybalance` output, you may need to be added to the allocation. Allocation 
coordinators can [add and remove users from their allocations](managing-accounts.md), or the allocation owner can contact the helpdesk at
[icds@psu.edu] to request a user be added.

## Custom Hardware Requests

Paid accounts can fine-tune their resource request using the `--constraint` directive.

From within a submit script, the constraint feature can be used by adding the following to 
your SBATCH header:

```
#SBATCH --constraint=<feature>
```

where `<feature>` is one of the features listed by sinfo (or multiple features, separated by commas).

To request nodes with a given feature for an interactive job,  
add a `-C` option to your `salloc` command:

```
salloc -N 1 -n 4 -A <alloc> -C <feature> -t 1:00:00
```

Any of the "tags" listed in the AVAIL_FEATURES column from the [sinfo output](../cli/slurm.md/#sinfo) 
can be used as a constraint to customize your hardware requests. 

For example, to request a job only run on 
`cascadelake` hardware, you would add the following directive to your resource requests:
```
--constraint=cascakelake
```

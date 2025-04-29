# Paying for compute

To access newer hardware including GPUs, to run jobs without risk of pre-emption,
and to run with wall times longer than the 48-hour limit on the open queue,
users must pay for compute time.

There are two ways to pay for compute time on Roar:  credit accounts, and allocations.

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

## Prices

Prices for different compute nodes are set proportional to the cost of the hardware,
and at a level competitive with the cost of buying your own cluster.
More expensive nodes cost more to use, reflecting their greater value.

Current prices for credit accounts and allocations are [here][prices].
[prices]: https://www.icds.psu.edu/roar-restricted-and-roar-collab-price-lists-2025/#

## Monitoring usage

The `get_balance` command displays current balances for both credit accounts and allocations.
To learn how to view details for specific accounts and people, use `get_balance --help`.

!!! warning "Request only the hardware you actually need."
	Jobs paid for by credit accounts will be charged 
	for the requested hardware, for the actual runtime of the job,
	whether or not it is actually used.

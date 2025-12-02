# Managing compute

## Adding and removing users

Account coordinators can add and remove other users and coordinators.
The account owner is automatically designated as an account coordinator, 
but they can appoint other users to serve as coordinators.

To add and remove users from a compute account, use `sacctmgr`:

```
$ sacctmgr add user account=<compute-account> name=<userid>
$ sacctmgr remove user account=<compute-account> name=<userid>
```

## Adding coordinators

To add or remove coordinators:

```
$ sacctmgr add coordinator account=<compute-account> name=<userid>
$ sacctmgr remove coordinator account=<compute-account> name=<userid>
```

!!! warning "Account coordinators control ALL access to the account"
    Coordinators can add and remove other coordinators, including the account owner.


## Monitoring usage

The `get_balance` command displays current balances for both credit accounts and allocations.
To learn how to view details for specific accounts and people, use `get_balance --help`.

!!! warning "Request only the hardware you actually need."
	Jobs paid for by credit accounts will be charged 
	for the requested hardware, for the actual runtime of the job,
	whether or not it is actually used.

# Managing compute

By default, only the resource owner has access to compute accounts. However, additional 
users and coordinators can be added.

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

Account coordinators are users that have the ability to add and remove other users from 
a compute account.

!!! warning "Account coordinators control ALL access to the account"
    Coordinators can add and remove other coordinators, including the account owner.

To add or remove coordinators:

```
$ sacctmgr add coordinator account=<compute-account> name=<userid>
$ sacctmgr remove coordinator account=<compute-account> name=<userid>
```

!!! tip "Coordinators are not automatically users"
    Adding someone as a coordinator does not automatically grant them user level permission 
    to the account. They will also need to be [added as a user](#adding-and-removing-users) 
    to be able to use the account for jobs.


## Monitoring usage

The `get_balance` command displays current balances for both credit accounts and allocations.
To learn how to view details for specific accounts and people, use `get_balance --help`.

!!! warning "Request only the hardware you actually need."
	Jobs paid for by credit accounts will be charged 
	for the requested hardware, for the actual runtime of the job,
	whether or not it is actually used.

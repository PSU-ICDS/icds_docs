# Managing compute

By default, only the resource owner has access to compute accounts. <br>
However, additional users and coordinators can be added.

## Adding users

Account coordinators can add and remove other users and coordinators. <br>
The account owner is automatically a coordinator.

To add and remove users of a compute account, use `sacctmgr`:

```
$ sacctmgr add user account=<compute-account> name=<userid>
$ sacctmgr remove user account=<compute-account> name=<userid>
```

## Adding coordinators

!!! warning "Account coordinators control ALL access to the account"
    Coordinators can add and remove other coordinators, including the account owner.

To add or remove coordinators:

```
$ sacctmgr add coordinator account=<compute-account> name=<userid>
$ sacctmgr remove coordinator account=<compute-account> name=<userid>
```

!!! tip "Coordinators are not automatically users."
    Adding a coordinator does not automatically grant them permission 
    to use the account.


## Monitoring usage

`get_balance` displays current balances for credit accounts and allocations. <br>
For help, use `get_balance --help`.

!!! warning "Request only the hardware you need."
	Jobs paid by credit accounts are charged 
	for requested hardware, whether or not it is used.

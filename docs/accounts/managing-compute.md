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


## Monitoring available balance

The `get_balance` command displays current balances for both credit accounts and allocations.
To learn how to view details for specific accounts and people, use `get_balance --help`.

!!! warning "Request only the hardware you actually need."
	Jobs paid for by credit accounts will be charged 
	for the requested hardware, for the actual runtime of the job,
	whether or not it is actually used.


## Managing child accounts


### Creating a child account

```
my_account create account=<child crch account> parent=<parent_cr_account>
```

Account ids are in the form of `prefix_type_suffix`, where type is `crch` for child accounts. 
Child accounts can have custom suffixes but must inherit the prefix of the parent account.

For example, for a parent account named `research_cr_default`, the child account 
`research_crch_professor1` is valid where `research2_crch_default` is not.

### Adding users and coordinators

```
my_account add account=<child crch account> user=userid coordinator=user=id
```

users are granted use access of the account
coordinators are granted coordinator and use access of the account

### Set available balance

```
my_account set available=n account=<child crch account>
```

where n is the desired available balance in the child account

!!! note Child accounts are authorized spenders with a credit limit, not independent accounts
    Credits are not removed from the parent account until they are spent. The child balance 
    is a maximum spending limit against the pool of credits held in the parent account. The 
    parent account balance contains the total credits available to all child accounts.
    
    It is possible for the child account's available balance to fall below the set 
    threshold if the balance in the parent account is low.

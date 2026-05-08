# Managing compute 2

When a new compute account is created, only the account owner is added and granted 
coordinator access. As coordinator, they can add and remove other users and coordinators. 
For credit accounts, these coordinators can also create and manage child accounts and usage limits.

## Reserved allocations

Reserve allocations are administered using the `sacctmgr` utility in a shell session either 
through the portal or an SSH connection.


### Adding users

Account coordinators can add and remove other users and coordinators. <br>
The account owner is automatically a coordinator.

To add and remove users of a compute account, use `sacctmgr`:

```
$ sacctmgr add user account=<compute-account> name=<userid>
$ sacctmgr remove user account=<compute-account> name=<userid>
```

### Adding coordinators

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


## Credit accounts

To manage credit accounts, coordinators can either use the graphical Slurm Account Manager 
found on the Portal or the command line utility `my_account`.

To access the Slurm Account Manager, 


### Slurm Account Manager

#### Manage users and coordinators

Account coordinators can add and remove other users and coordinators. <br>
The account owner is automatically a coordinator.

Users and coordinators can be added by entering their ID in the text box and clicking 
"Add User"(1) or "Add Coordinator"(2) as desired. 

![Add user or add Coordinator entry box on Slurm Account Manager](../img/acct-mgr-add-user.png)

!!! tip "Add multiple people at once."
    The form will accept a list of comma-separated IDs, allowing you to enter several people
    in a single step.
    

To change permissions of an existing individual, you can click the buttons next to their 
entry in the list of Users. To grant a user the role of Coordinator, click "Promote".

![Promote button on Slurm Account Manager](../img/acct-mgr-promote.png)

Alternately, to remove Coordinator permissions but continue to allow access as a user, click "Demote"(1).
Clicking "Make Coordinator Only"(2) removes only user permissions while maintaining access as a Coordinator.

![Demote and Make Coordinator Only button on Slurm Account Manager](../img/acct-mgr-demote.png)

To remove all access, select users to remove by clicking the checkbox next to their ID and 
clicking the "Remove Selected Users" button.

![Remove Selected Users on Slurm Account Manager](../img/acct-mgr-remove.png)

!!! note Inherited coordinators cannot be removed from child accounts.
    Child accounts automatically inherit all of the coordinators from the parent account. 
    These inherited coordinators cannot be removed while they remain coordinators of the 
    parent account.


#### Create and manage child accounts

Credit accounts can serve as parents to one or more child accounts, allowing the balance 
credits in the parent account to be shared with the child accounts.

Child account names take the form of `<prefix>_crch_<suffix>` where the prefix is set to that 
of the parent account. Child accounts can have custom suffixes but must inherit the prefix of the parent account.

For example, for a parent account named `research_cr_default`, the child account 
`research_crch_professor1` is valid where `research2_crch_default` is not.


To create a child account, click the "Add Child" button located next to the top of the 
account detail box.

![Add Child account on Slurm Account Manager](../img/acct-mgr-add-child.png)

Enter the desired suffix in the text box(1) and if desired, the Penn State Access ID for 
any users(2) and coordinators(3) to be added to the child account. Then click "Create"(3).

![Create Child Account on Slurm Account Manager](../img/acct-mgr-create.png)

Once the child account is created, 
[additional users and coordinators can be added](#on-the-portal) as well.

#### Setting usage limits

The available balance of credits can be set for individual users or child accounts. These 
limits are completely independent of the total credits available in the account.

!!! warning "It is possible to over-allocate credits"
    Available credit limits just limit how many credits can be used by an individual 
    user or account. They are not bound by the available credits, and it is possible to 
    allow more available credits than is actually in the parent account.


Available credit balances can be set using the "Set Credit Usage Limits" box. Enter the 
desired credit amount in the box(1) and select how you want the limit applied. For individual 
user limits, click the checkbox before each target user and choose the "Selected users"(2) 
option.

For account level limits, choose "Account"(2). Please note account limits can only be set 
on accounts by coordinators of the parent account.

Then click "Set" to activate.

![Set available credit limits on Slurm Account Manager](../img/acct-mgr-set-limit.png)

Available limits can also be set relative to current levels using a +n or -n entry. For example, 
to set the available limit 100 credits higher than the current limit, +100 can be entered 
in the limit field.

![Set relative credit limit on Slurm Account Manager](../img/acct-mgr-rel-limit.png)

### my_account command line utility

#### Manage users and coordinators

Account coordinators can add and remove other users and coordinators. <br>
The account owner is automatically a coordinator.


Coordinators can 

```
my_account add account=<child crch account> user=userid coordinator=user=id
```

users are granted use access of the account
coordinators are granted coordinator and use access of the account

To remove users, the `remove` subcommand can be used

```
my_account remove account=<child crch account> user=userid coordinator=user=id
```

!!! note Inherited coordinators cannot be removed from child accounts.
    Child accounts automatically inherit all of the coordinators from the parent account. 
    These inherited coordinators cannot be removed while they remain coordinators of the 
    parent account.



#### Create and manage child accounts

Credit accounts can serve as parents to one or more child accounts, allowing the balance 
credits in the parent account to be shared with the child accounts.

Child account names take the form of `<prefix>_crch_<suffix>` where the prefix is set to that 
of the parent account. Child accounts can have custom suffixes but must inherit the prefix of the parent account.

For example, for a parent account named `research_cr_default`, the child account 
`research_crch_professor1` is valid where `research2_crch_default` is not.



To create a child account with the `my_account` utility, you would use the `create` subcommand
```
my_account create account=<child crch account> parent=<parent_cr_account>
```

Users and coordinators can be added at the same time the child account is created, by also 
including the `user` and `coordinator` arguments

```
my_account create account=<child_crch_account> parent=<parent_cr_account> user=<userid> 
coordinator=<coordid>
```


#### Setting usage limits

The available balance of credits can be set for individual users or child accounts. These 
limits are completely independent of the total credits available in the account.

!!! warning "It is possible to over-allocate credits"
    Available credit limits just limit how many credits can be used by an individual 
    user or account. They are not bound by the available credits, and it is possible to 
    allow more available credits than is actually in the parent account.


```
my_account set available=n account=<child crch account>
```

where n is the desired available balance in the child account



## Monitoring available balance

`get_balance` displays current balances for credit accounts and allocations. <br>
For help, use `get_balance --help`.

!!! warning "Request only the hardware you need."
	Jobs paid by credit accounts are charged 
	for requested hardware, whether or not it is used.

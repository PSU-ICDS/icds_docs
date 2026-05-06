# Managing compute

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



### Manage users and coordinators

Account coordinators can add and remove other users and coordinators. <br>
The account owner is automatically a coordinator.

#### On the Portal

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


#### On the command line

Coordinators can 

### Adding users and coordinators

```
my_account add account=<child crch account> user=userid coordinator=user=id
```

users are granted use access of the account
coordinators are granted coordinator and use access of the account


### Create and manage child accounts

Credit accounts can serve as parents to one or more child accounts, allowing the balance 
credits in the parent account to be shared with the child accounts.

Child account names take the form of `<prefix>_crch_<suffix>` where the prefix is set to that 
of the parent account. The suffix is completely customizable. For example, any 
child account of `support_cr_default` would be named `support_crch_<prefix>`.

!!! note Child accounts are authorized spenders with a credit limit, not independent accounts
    Credits are not removed from the parent account until they are spent. The child balance 
    is a maximum spending limit against the pool of credits held in the parent account. The 
    parent account balance contains the total credits available to all child accounts.
    
    It is possible for the child account's available balance to fall below the set 
    threshold if the balance in the parent account is low.
    
#### On the Portal

To create a child account, click the "Add Child" button located next to the top of the 
account detail box.

![Add Child account on Slurm Account Manager](../img/acct-mgr-add-child.png)

Enter the desired suffix in the text box(1) and if desired, the Penn State Access ID for 
any users(2) and coordinators(3) to be added to the child account. Then click "Create"(3).

![Create Child Account on Slurm Account Manager](../img/acct-create.png)

Once the child account is created, 
[additional users and coordinators can be added](#on-the-portal) as well.

#### On the command line

##### Creating a child account

```
my_account create account=<child crch account> parent=<parent_cr_account>
```

Account ids are in the form of `prefix_type_suffix`, where type is `crch` for child accounts. 
Child accounts can have custom suffixes but must inherit the prefix of the parent account.

For example, for a parent account named `research_cr_default`, the child account 
`research_crch_professor1` is valid where `research2_crch_default` is not.

### Setting usage limits

The available balance of credits can be set for individual users or child accounts. These 
limits are completely independent of the total credits available in the account.

!!! warning "It is possible to over-allocate credits"
    Available credit limits just limit how many credits can be used by an individual 
    user or account. They are not bound by the available credits, and it is possible to 
    allow more available credits than is actually in the parent account.



    
#### On the Portal




#### On the command line


##### Set available balance

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
>>>>>>> 365d24c (All changes relative to staging)

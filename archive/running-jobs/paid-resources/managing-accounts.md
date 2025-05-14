# Managing Paid Accounts

To list the available compute accounts and the associated available burst partitions, use the following command:

```
$ sacctmgr show User $(whoami) --associations format=account%30,qos%40
```


## Managing Compute Accounts

### Adding and Removing Users

A coordinator can add and remove users from the compute account using the following:

```
$ sacctmgr add user account=<compute-account> name=<userid>
$ sacctmgr remove user account=<compute-account> name=<userid>
```

### Adding and Removing Account Coordinators

Account coordinators can control access to a compute account by adding and removing other users and coordinators.
The account owner is automatically designated as the account coordinator, but they can appoint other users to 
serve as coordinators in addition to or in place of themselves.
 
To add or remove account coordinators:

```
$ sacctmgr add coordinator account=<compute-account> name=<userid>
$ sacctmgr remove coordinator account=<compute-account> name=<userid>
```

!!! warning "Account Coordinators can control all access to the account"
    Coordinators have the ability to add and remove other coordinators to the account, including the account owner.


## Managing Access to Group Storage

Group storage access is managed by collab groups. Each account owner has a collab group that has access 
to their group storage directory by default. To add and remove users from a collab group, please have the 
group owner send in a request to <icds@psu.edu>.

For custom group storage configurations including multiple collab groups or varying subdirectory permissions, 
please contact <icds@psu.edu> for more information.

### User-Managed Groups

If the owner of a group space would like more control over the access groups or would like to designate a group coordinator, then it is recommended that the owner [create a User Managed Group (UMG)](https://pennstate.service-now.com/sp?id=kb_article_view&sysparm_article=KB0011865&sys_kb_id=81102ada87cedd10d7bf7485dabb35b0&spa=1). 
The UMG allows a user to manage the group access list and group roles directly through the User Managed Group functionality through [Penn State Accounts Management](https://accounts.psu.edu/manage). 
Select the following options and adhere to the following recommendations when creating the UMG:

```
Group Function:     Functional
Campus:             University Park
Display Name:       icds.rc.<umg_name>
                    e.g. icds.rc.abc1234_collab
Email:              Not necessary for RC use
Security:           Sync with Enterprise Active Directory is required
```

ICDS filters UMGs for display names that begin with `icds.rc.`, so any UMGs created with this prefix will automatically appear within RC. 
It may take up to 15 minutes for a newly created UMG to appear on RC. 
To verify that a UMG is available on RC, run the following command on RC:

```
$ getent group icds.rc.<umg_name>
```

After a UMG is created, the owner can submit a request to **icds@psu.edu** to associate this UMG with the `<owner>_collab` group. 
Once the association between the UMG and the `<owner>_collab` group is made, then the group owner has full dynamic control over the access and roles of the `<owner>_collab` group by modifying the UMG membership. 
After this single request to ICDS, the owner no longer must submit requests to modify group membership and instead can manage the group directly. 
Note that any user added as a UMG member that *does not* have an active Roar account will not have access to Roar or any data on Roar until that user has an active Roar account.


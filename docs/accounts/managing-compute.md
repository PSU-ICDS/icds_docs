# Managing accounts

Account coordinators can add and remove other users and coordinators.
The account owner is automatically designated as an account coordinator, 
but they can appoint other users to serve as coordinators.

To add and remove users from a compute account, use `sacctmgr`:

```
$ sacctmgr add user account=<compute-account> name=<userid>
$ sacctmgr remove user account=<compute-account> name=<userid>
```

To add or remove coordinators:

```
$ sacctmgr add coordinator account=<compute-account> name=<userid>
$ sacctmgr remove coordinator account=<compute-account> name=<userid>
```

!!! warning "Account coordinators control ALL access to the account"
    Coordinators can add and remove other coordinators, including the account owner.


## Group storage

Group storage access is controlled by membership in collab groups. 
Each account owner has a collab group, which has access to their group directory. 
To add and remove users from a collab group, 
the group owner must send a request to <icds@psu.edu>.

To customize group storage permissions, 
such as creating multiple collab groups or changing subdirectory permissions, 
contact <icds@psu.edu>.

## User-managed groups

If a group space owner wants more control over access,
or wants to designate a group coordinator, 
they may wish to create a User Managed Group [(UMG)][UMG].
A UMG allows a group space owner to manage the group access list and group roles 
via [Penn State Accounts Management](https://accounts.psu.edu/manage). 
To create a UMG, select the following options:
[UMG]: https://pennstate.service-now.com/sp?id=kb_article_view&sysparm_article=KB0011865&sys_kb_id=81102ada87cedd10d7bf7485dabb35b0&spa=1
```
Group Function:     Functional
Campus:             University Park
Display Name:       icds.rc.<umg_name>
                    e.g. icds.rc.abc1234_collab
Email:              Not necessary for RC use
Security:           Sync with Enterprise Active Directory is required
```

ICDS filters UMGs for display names that begin with `icds.rc.`, 
so any UMGs created with this prefix will automatically appear on Roar. 
It may take up to 15 minutes for a newly created UMG to appear. 
To verify that a UMG is available, run the following command:

```
$ getent group icds.rc.<umg_name>
```

After a UMG is created, the owner can submit a request to <icds@psu.edu> 
to associate this UMG with the `<owner>_collab` group. 
Then the group owner has control over access and roles of the `<owner>_collab` group,
by modifying the UMG membership. 
Therafter, the owner can modify group membership directly, without contacting ICDS.
(Note that any user added as a UMG member must have an active Roar account 
to access data on Roar.)


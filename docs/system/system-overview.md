# System overview

Compute clusters like Roar serve many purposes:

- **number crunching**, much bigger and faster than a laptop
- **batch compute jobs**, submitted and performed later
- **interactive computing**, on the equivalent of a powerful workstation
- **large-scale storage** and access of data files

## Architecture

Roar consists of different parts, connected together by networks:

- **users** of the cluster, who connect to either
- **the Portal**, for interactive computing, or
- **submit nodes**, to prepare and submit jobs;
- **file storage** for user files, plus
- **scratch storage** for temporary files; and 
- **compute nodes**, of several different types.

![architecture](../img/RC-architecture-schematic.png)

Additional information on the Roar Collab system configuration can be found in 
[Compute Hardware](compute-hardware.md)

## Accounts

To log on to Roar, you need a [login account](connecting.md/#login-accounts).
To work on Roar, you can use the open queue at no cost,
which gives you access to the Portal, 
and to batch jobs on vintage hardware.

But to use any of the newer, more powerful hardware, 
you need either a paid [credit account](../accounts/paid-resources.md), 
or a paid [allocation](../accounts/paid-resources.md).
With credit accounts, you pay only only the compute resources you use,
and can use any type of nodes you need.
However, if you require prompt access to specific hardware,
you can opt for an allocation ---
in which you reserve specific hardware,
and pay whether or not you use the compute time.

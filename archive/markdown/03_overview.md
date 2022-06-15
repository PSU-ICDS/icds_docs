
---
title: System Overview
---

Roar is a heterogeneous cluster that consists of multiple node-types connected to a common file system. The primary portions are ACI-b, the batch portion of the cluster; ACI-i, the interactive portion; and the data-manager nodes.

  

#### 3.1 ACI-b

ACI-b, the batch portion of Roar, is used to submit jobs to dedicated resources. ACI-b has the hostname

`submit.aci.ics.psu.edu`

and can be logged into using `ssh`. Users will be placed on a head node, which is not intended for heavy processing. The head node should only be used to submit jobs.  

Typically, a job submission script including the resource requests and the commands is submitted. A job scheduler will wait until dedicated resources are available for this job. Jobs are submitted either to the Open Queue allocation, which any Penn State student/faculty/staff are able to use, or to a paid allocation. Jobs are typically submitted with the qsub command:

`qsub subScript.pbs`

##### <span class="titlemark">3.1.1</span> Types of ACI-b Nodes

Compute resources are available in four configurations: Basic Memory, Standard Memory, High Memory, and GPU.

|Node Types|Specifications|
|--- |--- |
|Basic|2.2 GHz Intel Xeon Processor, 24 CPU/server, 128 GB RAM, 40 Gbps Ethernet|
|Standard|2.8 GHz Intel Xeon Processor, 20 CPU/server, 256 GB RAM, FDR Infiniband, 40 Gbps Ethernet|
|High|2.2 GHz Intel Xeon Processor, 40 CPU/server, 1 TB RAM, FDR Infiniband, 10 Gbps Ethernet|
|GPU|2.5 GHz Intel Xeon Processor, 2 Nvidia Tesla K80 computing modules/server, 24 CPU/server, Double Precision, FDR Infiniband, 10 Gbps Ethernet|

  

#### 3.2 ACI-I

ACI-i provides a set of interactive cores that are configured as common GUI interactive systems. ACI-i is a shared resource where users are placed on an interactive node with other users.  

ACI-i may only be [accessed via Open OnDemand](https://www.icds.psu.edu/userguide/05-00-basics-aci-resources/05-04-connecting-aci/05-041-open-ondemand/).

Often ACI-i is used to develop and test small scale test cases due to the ability to use a graphical user interface. Once the model has been developed, it can be submitted as a job to ACI-b to take advantage of the greater computational resources available on ACI-b.  

For example, a researcher might log in to ACI-i to develop a finite element model using the graphical user interface for COMSOL. To test the model, small simulations on a course mesh can be run on ACI-i. Then once the model has been deemed satisfactory, the researcher can log in to ACI-b to submit the COMSOL model using a much finer mesh.  

Individual processes are limited to

*   4 processors
*   12 CPU hours per process
*   48 GB resident memory

on ACI-i. Note that the resident memory constraint still allows for memory that can be sent to virtual memory during times of high usage.  

  

#### 3.3 Roar Open Queue

All Penn State students, faculty and staff are able to run on the Roar “open queue” on ACI-b for no charge. The current limits per user on the open queue are:

*   <span class="normaltextrun"><span lang="">100 jobs pending</span></span>
*   <span class="normaltextrun"><span lang="">100 cores executing jobs at any given time</span></span>
*   <span class="normaltextrun"><span lang="">48-hour job wall-times</span></span>
*   <span class="normaltextrun"><span lang="">24-hour interactive session durations</span></span><span class="eop"><span lang=""> </span></span>

Jobs requiring more time or processors than this are required to run on an allocation.  

Jobs running on the open allocation are placed on available compute nodes. These are available as they are not being used by the group who has an allocation reservation on that node. If that group does require these resources, the running open queue jobs are pre-empted. Once the allocation job has completed, your job will continue, if the code running allows for this to occur.  

ACI-i is open to any and all users, regardless of allocation.  

  

#### 3.4 HPRC

HPRC is the hybrid-cloud portion of Roar, utilizing virtual cores at a lower cost. HPRC jobs are submitted from ACI-b head nodes, with the host name

`submit.aci.ics.psu.edu`

…and can be logged into using ssh.

Users will be placed on a head node, which is not intended for heavy processing. The head node should only be used to submit jobs.

Typically, a job submission script including the resource requests and the commands is submitted. A job scheduler will wait until dedicated resources are available for this job. Jobs are typically submitted with the qsub command:

`qsub subScript.pbs`

  

#### 3.5 Filesystems

The Roar system has several filesystems available for users for active and archival storage. Active storage can be utilized by running jobs and archival storage is intended for long-term data storage.  

**Active Storage**  
All of the active storage is available from all of the Roar systems. Individual users have home, work and scratch directories that are created during account creation. The work and scratch directories should have links within the home directory, allowing for easy use. A user’s home directory is for personal files and cannot be shared. Work and scratch are able to be shared. Both home and work are backed up. Scratch is not backed up and files are subject to deletion 30 days after creation. _Do not keep important files on scratch._

Group directories can be created to help facilitate research within a group and can be purchased as an allocation. Note that individual allocations will have separate locations within the group directory.  

**Archival storage**  
The archival storage is only available on the [Data Manager](#03-05-data-manager) nodes. Archival storage can be purchased as an allocation.

By design, archival storage is best suited for storing relatively small numbers of large files that will be accessed infrequently. Compared to active storage, read and write performance in archive storage will be very slow. Attempting to utilize archive storage when active storage would be more appropriate can result in system degradations that negatively impact all users of our shared system. Limiting files to a minimum 1GB or 1000 per TB is a good rule of thumb.

|Space|Location|Quota|File Limit|Backed-Up|File Lifetime Limit|
|--- |--- |--- |--- |--- |--- |
|Home|/storage/home/userID|10 GB|500,000|Yes|None|
|Work|/storage/work/userID|128 GB|1,000,000|Yes|None|
|Scratch|/gpfs/scratch/userID|None|1,000,000|No|30 Days|
|Group|/gpfs/group/groupID|5 TB blocks|1,000,000 per TB|Yes|None|
|Archive|/archive/groupID|5 TB blocks|Suggested lower limit of 1G/file or 1,000/TB|No|None|


  

#### 3.6 Data Manager

The data manager nodes are dedicated to file transfers, both within Roar and between Roar and other systems. For active storage, it can be used with command line file-transfer tools, such as `rsync`, `sftp` or `scp`, as well as with Globus, WinSCP, or FileZilla.  

The data manager hostname is

`datamgr.aci.ics.psu.edu`

For example, to connect to data manager, you can use the command

`ssh datamgr.aci.ics.psu.edu`

to log in. After logging in, you can perform your file transfer.

**Important:** Do not use tools that attempt to mirror or replicate directory and file trees (such as rsync) into archive storage. Using such tools with archive storage can result in system degradations that negatively impact all users of our shared system.

  
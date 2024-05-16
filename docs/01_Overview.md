
# Overview




## About ICDS

The Institute for Computational and Data Sciences (ICDS) is one of seven 
interdisciplinary research institutes within Penn State's Office of the Senior 
Vice President for Research. The mission of ICDS is to build capacity to solve 
problems of scientific and societal importance through cyber-enabled research. 
ICDS enables and supports the diverse computational and data science research 
taking place throughout Penn State. Users come from all corners of the 
university and conduct interdisciplinary research using the high-performance 
computing (HPC) systems delivered and supported by ICDS.


## High-Performance Computing Overview

High-performance computing (HPC) is the use of powerful computing systems that 
are capable of performing complex tasks and solving large-scale computational 
problems at significantly higher speeds and with greater efficiency than 
conventional computing systems. These tasks often involve processing and 
analyzing massive datasets, conducting simulations, modeling complex phenomena, 
and executing advanced algorithms. The increase in computational performance is 
a result of the aggregation of computing resources and utilizing those 
resources in concert to perform the computational process. HPC systems consist 
of many compute nodes that communicate over fast interconnections. Each node 
contains many high-speed processors and its own memory. Typically, the nodes 
also are connected to a shared filesystem. The seamless integration of the 
compute, storage, and networking components at a large scale is the fundamental 
essence of HPC. HPC plays a critical role in pushing the boundaries of academic 
research and enabling breakthroughs in science, engineering, and technology 
across diverse fields of study.


## Roar Collab User Flow Diagram

![RC User Flow Diagram](images/RCUserFlowDiagram.png)


## Roar Collab System Specs

Roar Collab (RC) is the flagship computing cluster for Penn State researchers. 
Designed with collaboration in mind, the RC environment allows for more 
frequent software updates and hardware upgrades to keep pace with researchers’ 
changing needs. RC utilizes the Red Hat Enterprise Linux (RHEL) 8 operating 
system to provide users with access to compute resources, file storage, and 
software. RC is a heterogeneous computing cluster comprised of different types 
of compute nodes, each of which can be categorized as a Basic, Standard,
High-Memory, GPU, or Interactive node.

| Node Type<br>(Designation) | Core/Memory<br>Configurations |Description |
| :----: | :----: | ---- |
| Basic<br>(`bc`) | 24 cores, 126 GB<br>64 cores, 255 GB | Connected via Ethernet<br>Configured to offer about 4 GB of memory per core<br>Best used for single-node tasks |
| Standard<br>(`sc`) | 24 cores, 258 GB<br>48 cores, 380 GB<br>48 cores, 512 GB | Connected both via Infiniband and Ethernet<br>Infiniband connections provide higher bandwidth inter-node communication<br>Configured to offer about 10 GB of memory per core<br>Good for single-node tasks and also multi-node tasks |
| High-Memory<br>(`hc`) | 48 cores, 1 TB<br>56 cores, 1 TB | Connected via Ethernet<br>Configured to offer about 25 GB of memory per core<br>Best for memory-intensive tasks |
| GPU<br>(`gc`) | 28 cores, 256 GB<br>28 cores, 512 GB<br>48 cores, 380 GB | Feature GPUs that can be accessed either individually or collectively<br>Both A100 and P100 GPUs are available |
| Interactive<br>(`ic`) | 36 cores, 500 GB | Feature GPUs that are specifically configured for GPU-accelerated graphics<br>Best for running graphical software that requires GPU-accelerated graphics |




[//]:<> (## Paid Allocation Specifications)
[//]:<> (tabular breakdown of nodes for purchase with associated characteristics)
<!---
<table>
    <thead>
        <tr>
            <th>Node Type</th>
            <th>Processor Generation</th>
            <th>Processor Type</th>
            <th>Cores</th>
            <th>Memory</th>
            <th>Allocation Memory per Core</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan=2>Basic</td>
            <td>broadwell</td>
            <td>Intel(R) Xeon(R) CPU E5-2650 v4 @ 2.20GHz</td>
            <td>24</td>
            <td>128 GB</td>
            <td>4 GB</td>
        </tr>
        <tr>
            <td>sapphirerapids</td>
            <td>Intel(R) Xeon(R) Gold 6430 @ 2.1GHz</td>
            <td>64</td>
            <td>256 GB</td>
            <td>4 GB</td>
        </tr>
        <tr>
            <td rowspan=3>Standard</td>
            <td>haswell</td>
            <td>Intel Xeon E5-2680v3 @ 2.5GHz</td>
            <td>24</td>
            <td>256 GB</td>
            <td>10 GB</td>
        </tr>
        <tr>
            <td>cascadelake</td>
            <td>Intel(R) Xeon(R) Gold 6248R CPU @ 3.00GHz</td>
            <td>48</td>
            <td>380 GB</td>
            <td>10 GB</td>
        </tr>
        <tr>
            <td>icelake</td>
            <td>Intel(R) Xeon(R) Gold 6342 CPU @ 2.80GHz</td>
            <td>48</td>
            <td>512 GB</td>
            <td>10 GB</td>
        </tr>
        <tr>
            <td rowspan=2>High-Memory</td>
            <td>broadwell</td>
            <td>Intel(R) Xeon(R) CPU E7-4830 v4 @ 2.00GHz</td>
            <td>56</td>
            <td>1 TB</td>
            <td>25 GB</td>
        </tr>
        <tr>
            <td>icelake</td>
            <td>Intel(R) Xeon(R) Gold 6342 CPU @ 2.80GHz</td>
            <td>48</td>
            <td>1 TB</td>
            <td>25 GB</td>
        </tr>
        <tr>
            <td rowspan=3>GPU</td>
            <td>broadwell</td>
            <td>CPU info + GPU info</td>
            <td>24</td>
            <td>256 GB</td>
            <td>8 GB</td>
        </tr>
        <tr>
            <td>broadwell</td>
            <td>CPU info + GPU info</td>
            <td>28</td>
            <td>512 GB</td>
            <td>8 GB</td>
        </tr>
        <tr>
            <td>cascadelake</td>
            <td>CPU info + GPU info</td>
            <td>48</td>
            <td>380 GB</td>
            <td>8 GB</td>
        </tr>
    </tbody>
</table>
-->




## Slurm's `sinfo` Command

RC is a heterogeneous computing cluster. To see the different node
configurations on RC, use the following command:

```
sinfo --Format=features:40,nodelist:20,cpus:10,memory:10
```

This `sinfo` command displays not only the core and memory configuration of the 
nodes, but it also indicates the processor generation associated with each 
node. Furthermore, while connected to a specific node, the `lscpu` command 
provides more detailed information on the specific processor type available on 
the node. For nodes with GPU(s), the `nvidia-smi` command displays more 
detailed information on the GPU(s) available on that node.

Slurm's [sinfo](https://slurm.schedmd.com/sinfo.html) 
documentation page provides a detailed description of the function and options 
of the `sinfo` command.


## Best Practices

Roar Collab is shared by many users, and a user's operating behavior can inadvertantly impact system functionality for other users. All users must follow a set of best practices which entail limiting activities that may impact the system for other users. Exercise good citizenship to ensure that your activity does not adversely impact the system and the RC research community.


!!! warning  "Do Not Run Jobs on the Submit Nodes"

    RC has a few login nodes that are shared among all users. Dozens, and sometimes hundreds, of users may be logged on at any one time accessing the file systems. Think of the submit nodes as a prep area, where users may edit and manage files, perform file management, initiate file transfers, submit new jobs, and track existing batch jobs. The submit nodes provide an interface to the system and to the computational resources.

    The compute nodes are where intensive computations may be performed and where research software may be utilized. All batch jobs and executables, as well as development and debugging sessions, must be run on the compute nodes. To access compute nodes on RC, either submit a batch job or request an interactive session. The [Submitting Jobs](03_SubmittingJobs.md) section of the RC User Guide provides further details on requesting computational resources.

    A single user running computationally expensive or disk intensive tasks on a submit node negatively impacts performance for other users. Additionally, since the submit nodes are not configured for intensive computations, the computational performance of such processes is poor. Habitually running jobs on the submit nodes can potentially lead to account suspension.


!!! warning  "Do Not Use Scratch as a Primary Storage Location"

    Scratch serves as a temporary repository for compute output and is explicitly designed for short-term usage. Unlike other storage locations, scratch is not backed up. Files are subject to automatic removal if they are not accessed within a timeframe of 30 days. The [Handling Data](04_HandlingData.md) section of the RC User Guide provides further details on storage options.


!!! tip  "Make an Effort to Minimize Resource Requests"
    
    The amount of time jobs are queued grows as the amount of requested resources increases. To minimize the amount of time a job is queued, minimize the amount of resources requested. It is best to run small test cases to verify that the computational workflow runs successfully before scaling up the process to a large dataset. The [Submitting Jobs](03_SubmittingJobs.md) section of the RC User Guide provides further details on requesting computational resources.


!!! tip  "Remain Cognizant of Storage Quotas"
    
    All available storage locations on RC have associated quotas. If the usage of a storage location approaches these quotas, software may not functional nominally and produce cryptic error messages. The [Handling Data](04_HandlingData.md) section of the RC User Guide provides further details on checking storage usage relative to the quotas.


## Policies

The policies regarding the use of RC can be found on the 
[ICDS Policies](https://www.icds.psu.edu/computing-services/roar-policies/) 
page.


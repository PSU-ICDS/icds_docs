
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
of compute nodes, each of which can be categorized as a Basic, Standard, High-
Memory, GPU, or Interactive node.

| Node Type | Designation | Description |
| ---- | ---- | ---- |
| Basic | `bc` | 
Connected via Ethernet<br>
Configured to offer about 4 GB of memory per core<br>
Best used for single-node tasks |
| Standard | `sc` | 
Connected both via Infiniband and Ethernet<br>
Infiniband connections provide higher bandwidth inter-node communication<br>
Configured to offer about 10 GB of memory per core<br>
Good for single-node tasks and also multi-node tasks |
| High-Memory | `hc` | 
Connected via Ethernet<br>
Configured to offer about 25 GB of memory per core<br>
Best for memory-intensive tasks |
| GPU | `gc` | 
Feature GPUs that can be accessed either individually or collectively<br>
Both A100 and P100 GPUs are available |
| Interactive | `ic` | 
Feature GPUs that are specifically configured for GPU-accelerated graphics<br>
Best for running graphical software that requires GPU-accelerated graphics |




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

Slurm's [sinfo](https://slurm.schedmd.com/sinfo.html) documentation page  
provides a detailed description of the function and options of the `sinfo` 
command.


## Best Practices




## Policies

The policies regarding the use of RC can be found on the 
[ICDS Policies](https://www.icds.psu.edu/computing-services/roar-policies/) 
page.



# Overview

Welcome to the Roar Collab (RC) User Guide!


## About ICDS

The Institute for Computational and Data Sciences (ICDS) is one of seven interdisciplinary research institutes within Penn State's Office of the Senior Vice President for Research. The mission of ICDS is to build capacity to solve problems of scientific and societal importance through cyber-enabled research. ICDS enables and supports the diverse computational and data science research taking place throughout Penn State. Users come from all corners of the university and conduct interdisciplinary research using the high-performance computing (HPC) systems delivered and supported by ICDS.


## Roar Collab (RC) System Specs

Roar Collab (RC) is the flagship computing cluster for Penn State researchers. Designed with collaboration in mind, the RC environment allows for more frequent software updates and hardware upgrades to keep pace with researchers’ changing needs. RC utilizes the Red Hat Enterprise Linux (RHEL) 8 operating system to provide users with access to compute resources, file storage, and software. RC is a heterogeneous computing cluster comprised of different types of nodes, each of which can be categorized as a Basic, Standard, High-Memory, GPU, or Interactive node.

Basic nodes (`bc` core-type designation) are connected via Ethernet and are best used for single-node tasks. Basic nodes are configured to offer about 4 GB of memory per core.

Standard nodes (`sc` core-type designation) are connected both via Infiniband and Ethernet. Standard nodes are good for single-node tasks and also multi-node tasks since the Infiniband connections provide higher bandwidth inter-node communication. Standard nodes are configured to offer about 10 GB of memory per core.

High-Memory nodes (`hc` core-type designation) nodes are connected via Ethernet and have more available memory, which makes this node type best for memory-intensive tasks. High-Memory nodes are configured to offer about 25 GB of memory per core.

On the GPU nodes (`gc` core-type designation), GPUs can be accessed either individually or collectively. Both A100 and P100 GPUs are available.

The Interactive nodes (`ic` core-type designation) feature GPUs that are specifically configured for GPU-accelerated graphics. Interactive node types are best for running intensive graphical software that requires GPU-accelerated graphics.


## High-Performance Computing Overview

High-performance computing (HPC) is the use of powerful computing systems that are capable of performing complex tasks and solving large-scale computational problems at significantly higher speeds and with greater efficiency than conventional computing systems. These tasks often involve processing and analyzing massive datasets, conducting simulations, modeling complex phenomena, and executing advanced algorithms. The increase in computational performance is a result of the aggregation of computing resources and utilizing those resources in concert to perform the computational process. HPC systems consist of many compute nodes that communicate over fast interconnections. Each node contains many high-speed processors and its own memory. Typically, the nodes also are connected to a shared filesystem. The seamless integration of the compute, storage, and networking components at a large scale is the fundamental essence of HPC. HPC plays a critical role in pushing the boundaries of academic research and enabling breakthroughs in science, engineering, and technology across diverse fields of study.


## Slurm's `sinfo` Command




## Best Practices and Good Citizenship




## Policies




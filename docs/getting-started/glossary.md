# Glossary & Key Concepts

This page idefines essential terms used throughout the Roar User Guide.  
Understanding these concepts will help you use the system efficiently and communicate clearly with support.

## Computing Cluster
A computing cluster is a collection of interconnected computers (nodes) that collaborate to perform computational tasks. The Roar computing cluster is a high-performance computing (HPC) system designed for research, comprising numerous nodes equipped with CPUs, GPUs, memory, and storage, all coordinated by the Slurm workload manager to process jobs efficiently.

## Node
A Node is a single physical computer in the Roar cluster.  
Each node has its own:

- CPU(s)
- Memory (RAM)
- Local storage (usually temporary)
- Network interface

Think of a node as a complete server dedicated to running jobs.  Multiple jobs can run on one node if resources allow.
Example > “Your job is running on node `submit03`”

## Processor
A processor (or CPU, Central Processing Unit) is the hardware component within a node responsible for executing computational tasks. A single processor contains multiple cores, each capable of running independent threads. For example, a node with two processors, each with 32 cores, provides 64 cores total.

## Core
A Core is a single processing unit within a CPU. Modern CPUs have multiple cores (e.g., 64 cores per node).
Cores execute tasks in parallel.  
When you request “8 cores,” you’re asking for 8 processing units — possibly on one node or across nodes.
Note:  

- 1 core = 1 CPU thread (unless hyper-threading is enabled)
- Parallel performance depends on your application’s ability to utilize multiple cores.

## GPU
A Graphics Processing Unit (GPU) is a specialized processor for parallel computation optimized for parallel computations, such as those used in machine learning, scientific simulations, and data visualization. The Roar cluster offers several GPU types:

- **A100**, **A40** — high-end, expensive
- **V100**, **P100** — mid-range, cost-effective

GPUs are only available to:
- Paid credit accounts
- Allocations with GPU access

Request via `--gres=gpu:<type>:<count>` in Slurm.  
See [Resource Requests](../running-jobs/resource-requests.md) for more detailed information on GPUs.

## Partition
A partition is a logical grouping of nodes in the Roar cluster, defined by shared access policies, time limits, and billing rates. Partitions allow the system to prioritize and allocate resources based on job requirements and user privileges.
See [Compute Hardware](../system/compute-hardware.md) for more details on available partitions.

## Directory
A Directory is a folder in the filesystem : a location where files are stored.
On Roar, key directories include the home, work, group and scratch directories.
See [File Storage & Filesystems](../file-system/file-storage.md) for full details.

## Environment Modules
Environment modules provide a flexible system for managing software environments on the Roar cluster. Modules allow users to load, unload, or switch between software packages, versions, or dependencies, ensuring the correct tools and libraries are available for specific tasks.

Example: To load Anaconda, run the command `module load anaconda` in the terminal. To list all available modules, use `module avail`. To unload Anaconda, run `module unload anaconda`, and to remove all modules and start fresh, run `module purge`.

See [Modules](../software/modules.md) for more detailed information.

## Environment Variables
Environment Variables are dynamic key-value pairs that configure the behavior of programs and scripts in the Roar cluster’s environment. They store information such as file paths, software settings, or system configurations, enabling seamless interaction with the cluster’s tools and resources.
Example: To add a custom directory to the PATH variable, run `export PATH=$PATH:/home/username/bin` in the terminal. To view all current environment variables, use the command `printenv`

Note: Environment variables are often set automatically by environment modules but can be customized for specific needs.
Since Roar uses RHEL, it sets the following variables for you - 

- $USER is your Penn State User ID. 
- $HOME points to your home directory (/storage/home/$USER).
- $WORK points to your work directory (/storage/work/$USER).
- $SCRATCH points to your scratch directory (/storage/scratch/$USER).

## Batch Jobs
A batch job is a non-interactive computational task submitted to the Roar cluster for execution without requiring user intervention. Managed by the Slurm workload manager, batch jobs are defined in scripts that specify commands, resource requirements, and output handling. The scheduler allocates resources and runs the job when available, making batch jobs ideal for long-running or resource-intensive computations.

See [Batch Jobs](../running-jobs/batch-jobs.md) for more detailed information.
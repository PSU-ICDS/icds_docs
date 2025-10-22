# Glossary & Key Concepts

This page ldefines essential terms used throughout the Roar User Guide.  
Understanding these concepts will help you use the system efficiently and communicate clearly with support.


## Node

A **node** is a single physical computer in the Roar cluster.  
Each node has its own:
- CPU(s)
- Memory (RAM)
- Local storage (usually temporary)
- Network interface

Think of a node as a **complete server** dedicated to running jobs.  
Multiple jobs can run on one node if resources allow.

**Example**:  
> “Your job is running on node `gpu-a100-03`.”


## Core

A **core** is a single processing unit within a CPU.  
Modern CPUs have multiple cores (e.g., 64 cores per node).

Cores execute tasks in parallel.  
When you request “8 cores,” you’re asking for 8 processing units — possibly on one node or across nodes.

**Note**:  
- 1 core = 1 CPU thread (unless hyper-threading is enabled)
- More cores = faster parallel computation (if your code supports it)


## Directory

A **directory** is a folder in the filesystem — a location where files are stored.

On Roar, key directories include the home, work, group and scratch directories.

See [File Storage & Filesystems](../file-system/file-storage.md) for full details.


## GPU

A **Graphics Processing Unit (GPU)** is a specialized processor for parallel computation — ideal for machine learning, simulations, visualization, etc.

Roar has multiple GPU types:
- **A100**, **A40** — high-end, expensive
- **V100**, **P100** — mid-range, cost-effective

GPUs are **only available** to:
- Paid credit accounts
- Allocations with GPU access

Request via `--gres=gpu:<type>:<count>` in Slurm.  
See [Hardware Requests](../running-jobs/hardware-requests.md) for more detailed information on GPUs.


## Partition

A **partition** is a logical group of nodes with shared access rules, time limits, and billing rates.

See [Compute Hardware](compute-hardware.md) for more details on available partitions.

**Tip**: List available partitions with:
```bash
sinfo -o "%20P %10c %10m %20f %G"
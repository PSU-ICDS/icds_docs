# Compute hardware

A cluster consists of multiple nodes connected to one or more central filesystems. 
A node is basically a single computer, roughly comparable to a powerful desktop machine. 
Some nodes are networked together with fast connections (Infiniband) that enable 
efficient communication between nodes, allowing large jobs to run in parallel on multiple nodes.
Finally, some nodes include GPUs (graphical processing units),
which can accelerate certain compute jobs.

The different types of nodes available on Roar are:

| Resource | Count | Cores | Memory <br> (GB) | CPU | CPU <br> Family | Network |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Basic | 120 <br> 240 | 64 <br> 24 | 256 <br> 128 | Gold 6430 <br> E5-2650v4 | sapphirerapids <br> broadwell | Ethernet|
| Standard | 140 <br> 156 <br> 233 <br> 36 | 48 <br> 48 <br> 24 <br> 64 | 512 <br> 384 <br> 256 <br> 384 | Gold 6342 <br> Gold 6248R <br> E5-2680v3 <br> EPYC 9354 | icelake <br> cascadelake <br> haswell <br> AMD Genoa | Infiniband |
| 2xGPU A100 <br> (40GB) | 38 | 48 | 384 | Gold 6248R | cascadelake | Infiniband |
| GPU V100 <br> (32GB)| 2 | 24 | 512 | E5-2680v3 | haswell | Ethernet |
| 4xGPU V100 <br> (32GB) | 2|  24 | 512 | Gold 6132 | skylake | Ethernet |
| GPU A40 <br> (48GB) | 12 | 36 | 1024 | Gold 6354 | icelake | Ethernet |
| GPU P100 <br> (12 GB) | 68 | 28 | 256 | E5-2680v4 | broadwell| Infiniband <br> Ethernet|
| High Memory | 25 <br> 2 | 48 <br> 56 | 1024 | Gold 6342 <br> E7-4830v4 | icelake <br> broadwell | Infiniband |
| interactive | 8  | 28 | 512 | E5-2680v4 <br> + P100 GPU | broadwell| Infiniband <br> Ethernet|

## Partitions

Nodes on Roar are grouped into four different hardware partitions:

- **basic** – CPU nodes without Infiniband, for jobs that fit on a single node.
- **standard** – CPU nodes with Infiniband (essential for multinode jobs).
- **himem** – CPU nodes with extra memory, for memory-intensive jobs.
- **interactive** – Nodes with graphics cards, that service the Portal.

All the various types of GPU nodes are grouped into the standard partition,
except the P100 GPU nodes that service the interactive partition.

In addition, there are two partitions not associated with specific hardware:

- **open** - Older CPU hardware, used with the open queue.
- **sla-prio** - For paid allocations, with whatever hardware the allocation includes.

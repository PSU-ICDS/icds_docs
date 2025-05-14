# System Overview

Compute clusters like Roar serve many purposes:

- **number crunching**, much bigger and faster than a laptop
- **batch compute jobs**, submitted and performed later
- **interactive computing**, on the equivalent of a powerful workstation
- **large-scale storage** and access of data files

Roar consists of two clusters:  **Roar Collab**, and **Roar Restricted**.
Roar Collab is for general use;
Roar Restricted is only for users working with sensitive data requiring extra security provisions.  
For details, see the [Roar Restricted](../roar-restricted/rr-getting-started.md) addendum.

## Architecture

Collab consists of different parts, connected together by networks:

- **users** of the cluster, who connect to either
- **submit nodes**, to prepare and submit jobs, or
- **the Portal**, for interactive computing;
- **file storage** for user files, plus
- **scratch storage** for temporary files; and 
- **compute nodes**, of several different types.

![architecture](../img/RCUserFlowDiagram.png)

## Compute Hardware

A cluster consists of multiple nodes connected to one or more central filesystems. 
A node is basically a single computer, roughly comparable to a powerful desktop machine. 

Some nodes are networked together with fast connections (Infiniband) that enable 
efficient communication between nodes, allowing large jobs to run in parallel 
on multiple nodes.

Finally, some nodes include GPUs (graphical processing units),
which can accelerate certain compute jobs.

## Available Hardware on RC

| Resource | Count | Cores | Memory (GB) | CPU | CPU Family | GPU | Network |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Basic | 120 <br> 240 | 64 <br> 24 | 256 <br> 128 | Gold 6430 <br> E5-2650v4 | sapphirerapids <br> broadwell | | Ethernet|
| Standard | 140 <br> 156 <br> 233 | 48 <br> 48 <br> 24 | 512 <br> 384 <br> 256 | Gold 6342 <br> Gold 6248R <br> E5-2680v3 | icelake <br> cascadelake <br> haswell | | Infiniband |
| GPU P100 | 8 <br> 68 | 28 | 512 <br> 256 | E5-2680v4 | broadwell |NVIDIA P100 12GB | Infiniband <br> Ethernet|
| GPU A100 | 38 | 48 | 384 | Gold 6248R | cascadelake | NVIDIA A100 40GB | Infiniband |
| GPU V100 | 2 | 24 | 512 | E5-2680v3 | haswell | NVIDIA V100 32GB | Ethernet |
| GPU V100 quad| 2|  24 | 512 | Gold 6132 | skylake | (4x) NVIDIA V100 32GB | Ethernet |
| GPU A40 | 12 | 36 | 1024 | Gold 6354 | icelake | NVIDIA A40 48GB | Ethernet |
| High Memory | 25 <br> 2 | 48 <br> 56 | 1024 | Gold 6342 <br> E7-4830v4 | icelake <br> broadwell | | Infiniband |
| AMD Genoa | 36 | 64 | 384 | EPYC 9354 | genoa | | Infiniband |

## Available Hardware on RR

| Resource | Count | Cores | Memory (GB) | CPU | GPU | Network |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Standard | 12 <br> 48 | 48 <br> 24 | 384 <br> 256 | Gold 6248R <br> E5-2680v3 || Infiniband |
| GPU P100 quad| 3 | 28 | 256 | E5-2680v4 | (4x) NVIDIA P100 12GB | Ethernet |
<!--
### Available Hardware on RC

### Available Hardware on RR
-->

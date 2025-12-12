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
| Basic | 120 | 64 | 256 | Gold 6430 | sapphirerapids | Ethernet|
| Standard | 140 <br> 35 | 48 <br> 64 | 512 <br> 384 | Gold 6342 <br> EPYC 9354 | icelake <br> AMD Genoa | Infiniband |
| 2xGPU A100 <br> (40GB) | 38 | 48 | 384 | Gold 6248R | cascadelake | Infiniband |
| GPU V100 <br> (32GB)| 2 | 24 | 512 | E5-2680v3 | haswell | Ethernet |
| 4xGPU V100 <br> (32GB) | 2|  24 | 512 | Gold 6132 | skylake | Ethernet |
| GPU A40 <br> (48GB) | 12 | 36 | 1024 | Gold 6354 | icelake | Ethernet |
| GPU P100 <br> (12 GB) | 60 | 28 | 256 | E5-2680v4 | broadwell| Infiniband <br> Ethernet|
| High Memory | 25 | 48 | 1024 | Gold 6342 | icelake | Infiniband |
| interactive | 16 | 28 | 512 | E5-2680v4 <br> + P100 GPU | broadwell| Infiniband <br> Ethernet|


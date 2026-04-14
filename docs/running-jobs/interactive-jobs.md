# Interactive jobs

Login nodes are for light work, like editing files and submitting jobs.
Compute-intensive tasks that require real-time user interaction -- 
such as working with MATLAB, debugging code, or running Gaussian calculations -- 
should not be run on login nodes. 

Instead, launch a [Portal session](portal.md),
or use `salloc` to request an interactive job on a compute node.

## salloc
 
`salloc` is a [Slurm][slurm] command, which allocates resources you request, 
and gives you a command-line prompt on a compute node,
where you can run compute-intensive commands.
[slurm]: slurm-scheduler.md

A typical command is:
```
salloc --nodes=1 --ntasks=4 --mem=16G --partition=standard --account=<account> --time=01:00:00
```
`salloc` takes many options.  Above, the options are:

* `--nodes` or `-N` is the number of nodes;
* `--ntasks` or `-n` is the number of cores;
* `--mem=16G` the total memory;
* `--partition=standard` is the partition;
* `-A or --account <account>` is the credit account or allocation;
* `--time` or `-t` is the run time.

To request an interactive job with a GPU, use `--gres=gps:a100:1` (for a single A100 GPU).
For requesting GPUs with credit accounts, use `--partition=standard`;
with a paid allocation that includes GPU nodes, use `--partition=sla-prio`.

For more details, see [Resource requests](resource-requests.md).

## VirtualGL

For interactive applications that produce graphical output 
(plots, figures, graphical user interfaces, and so on),
using VirtualGL can speed up the drawing.

For this to work, you must log on with [X forwarding](../getting-started/connecting.md#x-forwarding)
and run an interactive job on a GPU node.
Then, launch your application with `vglrun <application>`.




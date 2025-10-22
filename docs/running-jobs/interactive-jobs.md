# Interactive jobs

For compute-intensive tasks that require real-time user interaction—such as working with MATLAB, debugging code, or running Gaussian calculations—you should not run them on the login nodes. Login nodes are for light work like editing files and submitting jobs.

Instead, you must request an interactive session on a compute node. The salloc command does this by first finding and allocating the resources you request, and then giving you a new command prompt directly on that compute node.

You can then run all your intensive commands in that new shell for the duration of the allocation.
```
salloc --nodes=1 --ntasks=4 --mem=16G --account=<account> --time=01:00:00
```

`salloc` is a [Slurm][slurm] command, which takes many options.
In the above example, `--nodes` or `-N` is the number of nodes,
`--ntasks` or `-n` the number of cores, and `--time` or `-t` the run time.
[slurm]: slurm-scheduler.md

Option `-A or --account <account>` specifies your paid credit account or allocation;
to run under the open queue, use `-A open` or `--account open`

To request an interactive job with a GPU, under a credit account use

```
salloc --account=<credit_account> --partition=standard --ntasks=4 --mem=32G --time=01:00:00 --gres=gpu:a100:1
```

Under a paid allocation (that includes GPU nodes), use 

```
salloc --account=<your_allocation> --partition=sla-prio --ntasks=4 --mem=32G --time=01:00:00 --gres=gpu:a100:1
```

For more details, see [Hardware requests](hardware-requests.md).

!!!warning "GPUs are only available to paid accounts."
	To request GPUs for an interactive job,
	you must have a paid credit account,
	or a paid allocation that includes GPU nodes.

## Interactive Desktop

The Interactive Desktop provides a full graphical user interface (GUI) that runs on a compute node, similar to a remote desktop. This is ideal for running software with graphical components (e.g., MATLAB, Ansys Workbench) or for managing files and multiple terminal windows in a familiar visual environment.

To launch a session, navigate to the Roar Portal and select **Interactive Apps > Interactive Desktop** from the top menu. You will then be presented with a form to request the necessary computational resources.

For a detailed guide on how to choose your Account, Queue, number of cores, memory, and run time on this form, please see the **[Selecting Resources](portal.md#selecting-resources)** section of our Portal documentation.

## VirtualGL

For applications that produce graphical output 
(plots, figures, graphical user interfaces, and so on),
using OpenGL can speed up the drawing.

For this to work, you must either use the Portal,
or log on with [X forwarding](../getting-started/connecting.md#x-forwarding)
and run an interactive job on a GPU node.
Then, you can launch your application with 
```
vglrun <application>

Example : 
module load matlab
vglrun matlab
```





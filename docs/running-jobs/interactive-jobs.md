# Interactive jobs

Sometimes, we want to run a compute-intensive job interactively;
for example, a heavy MATLAB, Mathematica, or Gaussian calculation.
Login nodes are not designed for such work.
Instead, from a login node, start an "interactive batch" session:
```
salloc -N 1 -n 4 -A <account> -t 1:00:00
```

`salloc` is a [Slurm][slurm] command, which takes many options.
In the above example, `-N` is the number of nodes,
`-n` the number of cores, and `-t` the run time.
[slurm]: slurm-scheduler.md

Option `-A <account>` specifies your paid credit account or allocation;
to run under the open queue, use `-A open`. 

Once salloc starts, you can run compute-intensive jobs 
interactively on your resources.

To request an interactive job with a GPU, under a credit account use

```
salloc -A <account> -p standard --gres=gpu:1 ...
```

Under a paid allocation (that includes GPU nodes), use `-p sla-prio`.

For more details, see [Hardware requests](hardware-requests.md).

!!!warning "GPUs are only available to paid accounts."
	To request GPUs for an interactive job,
	you must have a paid credit account,
	or a paid allocation that includes GPU nodes.

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
```





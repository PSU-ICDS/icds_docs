# Interactive jobs

For compute-intensive tasks that require real-time user interaction—such as working with MATLAB, debugging code, or running Gaussian calculations—you should not run them on the login nodes. Login nodes are for light work like editing files and submitting jobs.

Instead, you must request an interactive session on a compute node. There are two main ways to do this.

## Portal interactive apps

Our [Web Portal](portal.md) provides a number of interactive apps including popular IDEs such as Jupyter, RStudio, and CodeServer. 
Additionally, the Interactive Desktop provides a full graphical user interface similar to a remote desktop where you can launch software 
with graphical components and manage files interactively.

[See our Portal documentation for more information](portal.md){ .md-button }

## Command line interactive sessions
 
The salloc command does this by first finding and allocating the resources you request, and then giving you a new command prompt directly on that compute node.

You can then run all your intensive commands in that new shell for the duration of the allocation.
```
salloc --nodes=1 --ntasks=4 --mem=16G --account=<account> --time=01:00:00
```

`salloc` is a [Slurm][slurm] command, which takes many options.
In the above example, `--nodes` or `-N` is the number of nodes,
`--ntasks` or `-n` the number of cores, and `--time` or `-t` the run time.
[slurm]: slurm-scheduler.md

Option `-A or --account <account>` specifies your paid credit account or allocation;

To request an interactive job with a GPU, under a credit account use

```
salloc --account=<credit_account> --partition=standard --ntasks=4 --mem=32G --time=01:00:00 --gres=gpu:a100:1
```

Under a paid allocation (that includes GPU nodes), use 

```
salloc --account=<your_allocation> --partition=sla-prio --ntasks=4 --mem=32G --time=01:00:00 --gres=gpu:a100:1
```

For more details, see [Hardware requests](resource-requests.md).

## Firefox

With Firefox, you can access OneDrive and other such sites,
and upload and download files. <br>
From the [Portal Interactive Desktop][portalID],
select Web Browser from the Applications menu.
[portalID]: ../getting-started/connecting.md#portal

Firefox is also available via `ssh -X`, after loading its module with 
`module load firefox`.   
From the command line, execute `firefox`.

Users may need to set the default browser manually using either:

- in their .bashrc file: 
```bash
BROWSER=/storage/icds/tools/sw/firefox/firefox 
```

- In an Interactive Desktop session, Applications > Settings > Settings Manager, then select Default Applications. Under the Internet tab, there is a field for Web Browser. Firefox is located at /storage/icds/tools/sw/firefox/firefox

!!! note "Using Firefox in Interactive Desktops"
    When using Firefox within an Interactive Desktop session, the operating system may ask for a path when you attempt to save or upload files. You can navigate to your storage directories using paths like `/storage/home/<username>` or `/storage/work/<username>`.

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





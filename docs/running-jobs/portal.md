# Portal

The Roar web [Portal][portal], powered by [Open OnDemand](https://openondemand.org/),
offers a visual desktop environment, file management, 
and Integrated Developer Environments (IDEs) such as Jupyter and RStudio.
[portal]: <https://portal.hpc.psu.edu>

## File management

You can access files on the Portal from the menu bar: **Files** > 
**Your Storage Location** (e.g., `home`, `work`, `scratch`, or `group` directories).

## Interactive jobs

You can run interactive jobs from the Portal home page, or by navigating via the top bar: 
**Interactive Apps** > **[Select the app you would like to run]**.

## Command line access

You can access the command line interface from the menu bar: **Clusters** -> **_RC Shell Access**. <br>
Or, you can launch the Terminal app (top left menu, **Applications** > **Terminal Emulator**) 
from within an Interactive Desktop session.

## Interactive Desktop

The Interactive Desktop provides a full graphical user interface (GUI) on a compute node. 
To launch a session, select **Interactive Apps > Interactive Desktop** from the top menu. 
For more details, see the [Open OnDemand documentation](https://openondemand.org/).

## Selecting resources

When launching an interactive app, you specify the computational resources for your job, 
using dropdowns and input fields on the application's launch page, including:

* **Account:** to pay for the job.
* **Partition:** the type of nodes where your job will run. 
(see [partitions](../system/system-overview.md)) 
* **Number and type of nodes:** how many and what kind <br> 
(e.g., standard CPU or GPU-enabled node).
* **Number of cores:** total number of CPU cores for your job.
* **Memory (RAM):** total memory, usually in Gigabytes (GB).
* **Run time:** maximum duration, in HH:MM:SS format.

!!! note "When using credits, specify a hardware partition."
	Credit accounts should use `basic`, `standard`, `himem`, or `interactive` partition.
	Allocations use the `sla-prio` partition. 

### Advanced Slurm options

With Slurm directives, you can customize your hardware allocation, 
and override form restrictions for node and core count, memory, and run time.

To do this, check "Enable advanced Slurm options", 
which causes the "Sbatch options" dialog box to appear.
There, you can specify [Slurm directives](slurm-scheduler.md/#slurm-directives) 
to customize your node and core count, memory, run time, or [hardware allocation](resource-requests.md).

For example, to request 8 cores (tasks), 128GB memory, and 8 hour run time,
the Sbatch options box should contain:

```
--ntasks=8
--mem=128GB
--time=8:00:00
```
    
!!! warning "Jobs must fit inside the resource limits of the partition they will run on."
     If a job requests resources that exceed the partition limits, they will not run.

### Requesting GPUs

To request a GPU with a Portal session, use [advanced Slurm options](#advanced-slurm-options) 
to enter a `--gres` directive, with the number and type of GPU needed
(e.g. `--gres=gpu:a100:1`).  See [GPUs](resource-requests.md#gpus).

## VirtualGL

For interactive applications that produce graphical output 
(plots, figures, graphical user interfaces, and so on),
using VirtualGL can speed up the drawing.

For this to work, you must request a Portal session with a GPU node.
Then, launch your application with `vglrun <application>`.  For example:
```
module load matlab
vglrun matlab
```

## Using custom environments

Jupyter and RStudio Server allow the use of custom environments. 
To use these, select "Use custom environment" under Environment type 
and enter commands to be run when the job launches.

For example, to use a custom Anaconda environment named `myenv`, 
the "Environment setup" box should contain:

```
module load anaconda
conda activate myenv
```

For more information, see [Anaconda on Portal](../packages/anaconda.md/#anaconda-on-portal).

## Firefox

The Firefox web browser is available from the [Portal Interactive Desktop][portalID]
(after logging in, select Web Browser from the Applications menu).
With Firefox, you can access OneDrive and other such sites,
and upload and download files.
[portalID]: ../getting-started/connecting.md#portal

Firefox is also available via `ssh -X`, 
after loading its module with `module load firefox`.   
From the command line, execute `firefox`.

Users may need to set the default browser.
This can be done in the `.bashrc` file, with
```
BROWSER=/storage/icds/tools/sw/firefox/firefox 
```
Or, in an Interactive Desktop session, navigate to 
Applications > Settings > Settings Manager, 
then select Default Applications. 
Under the Internet tab, there is a field for Web Browser;
Firefox is located at /storage/icds/tools/sw/firefox/firefox.

!!! note "Using Firefox in Interactive Desktops"
    When using Firefox to save or upload files, you may be prompted for a path.
    Your home and work directories are `/storage/home/<username>` and `/storage/work/<username>`.


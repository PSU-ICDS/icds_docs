# Anaconda

[Anaconda](https://www.anaconda.com/) is a package manager, originally developed for Python, 
but now used by several software platforms to manage package installation.

One such software platform is R, a widely used application for statistical analysis and 
plotting, which is greatly extensible by loading packages.

For more information on how to use Anaconda, we recommend 
["Introduction to Conda for (Data) Scientists"](https://carpentries-incubator.github.io/introduction-to-conda-for-data-scientists/) 
from [The Carpentries](https://carpentries.org/).

## Anaconda commands

This table summarizes useful Anaconda commands:

| Command | Description |
| ---- | ---- |
| `conda create –n <env_name>` | Creates a conda environment by name |
| `conda create –p <env_path>` | Creates a conda environment by location |
| `conda env list` | Lists all conda environments |
| `conda env remove –n <env_name>` | Removes a conda environment  |
| `conda activate <env_name>` | Activates a conda environment |
| `conda list` | Lists all packages in the active environment |
| `conda deactivate` | Deactivates the active environment |
| `conda install <package>` | Installs a package in the active environment |
| `conda search <package>` | Searches for a package |
| `conda env export > env_name.yml` | Save the active environment to a file |
| `conda env create –f env_name.yml` | Loads an environment from a file |


## Creating and managing environments

!!! tip "Anaconda should only be used on compute nodes."
	Anaconda processes running on the submit nodes are often killed. Please start an 
	interactive job first with [`salloc`](../running-jobs/interactive-jobs.md), 
	or a Persistent Terminal or Interactive Desktop session 
	on the [Portal](../running-jobs/portal.md).
	
To access Anaconda, first load its module with `module load anaconda`.

### Deactivating base environment

Older versions of Anaconda create a default base version, 
which can be identified by the text `(base)` at the front of your prompt. 
To avoid compatibility issues before loading or creating a new environment,
deactivate this environment with `conda deactivate`.

To avoid activating this base environment entirely, 
remove the `conda init` command from your `~/.bashrc` file, or 
[contact ICDS Support for assistance](../getting-started/getting-help.md).

### Finding packages

Packages can be found in two ways. First, searching by package 
name on the [Anaconda Package Repository](https://anaconda.org) 
will display all publicly available packages, 
and indicate the host channel, package version, and download count.

!!! tip "Select a current, highly-used package from a reputable channel"
	When selecting a package, use reputable channels such as `conda-forge` and `bio-conda`, 
	or developer channels such as `R`.  Check for a recent version number.
	Finally, commonly used packages will have a high download count.
	
Alternately, use `conda search <package>`, which searches for packages in channels
you have configured to use.  For example:

```
$ conda search r-tidyverse
Loading channels: done
# Name                       Version           Build  Channel
r-tidyverse                    1.0.0        r3.3.1_0  pkgs/r
r-tidyverse                    1.0.0        r3.3.2_0  pkgs/r
r-tidyverse                    1.1.1        r3.3.2_0  conda-forge
r-tidyverse                    1.1.1        r3.4.1_0  conda-forge
...
```

### Creating an environment

Once the desired modules are loaded, create a new environment using `conda create`:
```
conda create -n <environmentName>
```

Or, install packages into the new environment by specifying their name(s) at the 
end of the `conda create` command:

```
conda create -n <environmentName> <pkg1> <pkg2> <pkg3>
```

### Activating an environment
Once an environment is created, you can activate it using `conda activate`:
```
conda activate <environmentName>
```

### Installing packages in an existing environment

To add packages to an existing environment, 
first load the Anaconda module and activate the environment. 
Then, install additional packages using `conda install <package>`.

## Anaconda in batch scripts

To use an Anaconda environment in a batch script, 
include `module load anaconda` and `conda activate` commands 
at the top of the script.

## Anaconda on Portal

To use an Anaconda environment for Python or R in a Portal interactive session, 
special considerations apply. (see also [Portal custom environments](../running-jobs/portal.md/#using-custom-environments)).

### Jupyter server

The Jupyter server can be used with a pre-defined Python environment,
which you select from the "Environment type" dropdown menu 
that appears as you configure the session.

To use your own conda environment in a Jupyter Server session,
select "Use custom text field", which will contain 

```
module load anaconda3
```

For this to work, the `ipykernel` package must be installed into your environment beforehand.
To do this, in a terminal session execute:

```
conda activate <environment>
conda install -y ipykernel
```

Finally, you will need to set up the custom kernel for use in Jupyter. 
With the environment loaded, use the command:

```
ipython kernel install --user --name=<environment>
```

After this, when the interactive Jupyter session begins, 
the environment should be displayed in the kernel list.

### RStudio 

RStudio can be used with a default environment, 
selected from the "Environment selection" dropdown menu. 
Additional packages can be installed from within the RStudio interface;
alternatively, use `conda install` to add packages directly to the environment.

To use a custom environment in an RStudio session, select "Use custom text field", and enter:

```
module load anaconda
conda activate <environment>
export CONDAENVLIB=$WORK/.conda/envs/<environment>/lib
export LD_LIBRARY_PATH=$CONDAENVLIB:$LD_LIBRARY_PATH
```

The `export` commands help RStudio find some libraries while accessing the conda 
environment's R installation. The default location for conda environments is 
``$WORK/.conda/envs`. If your environment is installed elsewhere, `CONDAENVLIB` 
should be set accordingly. 

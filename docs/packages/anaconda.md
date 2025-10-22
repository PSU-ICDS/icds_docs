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


## Creating and Managing Environments

!!! tip "Anaconda should only be used on compute nodes"
	Anaconda processes running on the submit nodes are often killed. Please start an 
	interactive session first using the `salloc` command or running a Persistent Terminal 
	or Interactive Desktop session on the portal.
	
To access Anaconda, you will need to load the module:

```
module load anaconda
```

### Finding Packages

There are two primary ways to find available packages. the first is to search by package 
name on the [Anaconda Package Repository](https://anaconda.org). This will display all 
publicly available packages and provide information such as package version, download count, 
and host channel.

!!! tip "Select a current, highly-used package from a reputable channel"
	When selecting a package to use, check the version number for a recent version. Also, 
	try to pick reputable channels such as `conda-forge`, `bio-conda`, or developer channels 
	such as `R`. Download count will provide a clue on what packages are most commonly 
	selected
	
Alternately, you can find packages using the `conda search` command. This will only search 
channels that you have configured to use:

```
conda search <pkgName>
```

### Creating an Anaconda Environment

Once the module is loaded, we can create a new environment using `conda create`:
```
conda create -n <environmentName>
```

We can also install packages into the new environment by specifying their name(s) at the 
end of the `conda create` command:

```
conda create -n <environmentName> <pkg1> <pkg2> <pkg3>
```

### Using an Anaconda Environment
Once an environment is created, you can activate it using `conda activate`:
```
conda activate <environmentName>
```

### Installing packages in an Existing Environment

To add packages to an existing environment, activate the environment by first loading the 
Anaconda module and activating the environment (as above). Once active, you can install 
additional packages using `conda install`:
```
conda install <package>
```


## Anaconda in batch scripts

To use an Anaconda environment in a batch script, you will need to load the anaconda module 
and activate your environment before running your commands.

```
module load anaconda
conda activate <environmentName>
```


## Anaconda on Portal

If you want to use an Anaconda environment for Python or R in a Portal interactive session, 
special considerations apply. (see also [Portal custom environments](../running-jobs/portal.md/#custom-environments)).

### Jupyter Server

The Jupyter Server can be used with a pre-defined Python environment,
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

Finally,  you will need to set up the custom kernel for use in Jupyter. With the environment 
loaded, use the command:

```
ipython kernel install --user --name=<environment>
```

If this is executed correctly, then when the interactive Jupyter session begins, the 
environment should be displayed in the kernel list.

### RStudio 

Likewise, RStudio can be used with a default environment, selected from the 
"Environment selection" dropdown menu. While some additional packages can be installed 
from within the RStudio interface, it is often better to add packages directly to the 
environment by using the `conda install` command.

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

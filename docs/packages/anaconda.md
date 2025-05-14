# Anaconda

Anaconda is a package manager,
originally developed for Python, 
but now used by several software platforms
to manage package installation.

One such software platform is R,
a widely used application for statistical analysis and plotting,
which is greatly extensible by loading packages.

For more information, see
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


## Anaconda in batch scripts

To initialize Anaconda for use in batch scripts, 
your `.bashrc` file must be executed.  
This can be done in one of three ways:

- `source ~/.bashrc`  executes your `.bashrc` file;
- load your environment with `source activate <environmentName>`;
- begin your script with `#!/bin/bash`, which executes your `.bashrc` file.

## Example: R packages

To use Anaconda to manage the installation of R, first load its module: 
```
module load anaconda
```

Next, create an Anaconda "environment" (set of applications and packages)
with R as a "base":

```
conda create -y -n <environmentName> r-base
```

If you want some R package always to be loaded, include it in the package list:

```
conda create -y -n <environmentName> r-base r-plot3d r-ggplot
```

To activate an Anaconda environment:

```
conda activate <environmentName>
```

Within an active environment, to load a package, execute

```
conda install <package>
```



## Anaconda on Portal

If you want to use conda environments
for Python or R in a Portal interactive session, special considerations apply.
(see also [Portal custom environments](../running-jobs/portal.md/#custom-environments)).

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
ipython kernel install --user --name=<environment>
```

When the session begins, your environment is displayed in the kernel list.

### RStudio 

Likewise, RStudio can be used with a default environment,
selected from the "Environment selection" dropdown menu.
When the session starts,
additional R packages can be installed from an extensive list.

To use a custom environment in an RStudio session,
select "Use custom text field", and enter:

```
module load anaconda
conda activate <environment>
export CONDAENVLIB=$WORK/.conda/envs/<environment>/lib
export LD_LIBRARY_PATH=$CONDAENVLIB:$LD_LIBRARY_PATH
```

The `export` commands help RStudio find some libraries 
while accessing the conda environment's R installation. 
The default location for conda environments is `$WORK/.conda/envs`.
If your environment is installed elsewhere, 
`CONDAENVLIB` should be set accordingly. 

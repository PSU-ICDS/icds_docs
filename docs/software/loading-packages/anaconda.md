# Using Anaconda

Anaconda is a "package manager",
originally developed for Python, 
but now used by several software platforms
to manage installation of packages.

One such software platform is R,
a widely used application for statistical analysis and plotting,
which is greatly extensible by loading packages.

To learn more about Anaconda, we recommend the ["Introduction to Conda for (Data) Scientists" 
Lesson](https://carpentries-incubator.github.io/introduction-to-conda-for-data-scientists/) from [The 
Carpentries](https://carpentries.org/).

## Common Anaconda Commands

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


## Anaconda Example: R packages

To use Anaconda to manage the installation of R, first load its module: 
```
module load anaconda
```

Next, create an Anaconda "environment" (set of loaded applications and packages),
that contains R as a "base":

```
conda create -y -n <environmentName> r-base
```

If you want some R package always to be loaded, include it in the list of packages:

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

## Anaconda in batch scripts

To ensure that Anaconda is properly initialized 
for use in batch scripts, 
your `.bashrc` file must be executed.
This can be done in one of three ways:

- `source ~/.bashrc`  executes your `.bashrc` file;
- load your environment with `source activate <environmentName>`;
- begin your script with `#!/bin/bash`, which also executes your `.bashrc` file.

## Anaconda on Portal

Special considerations apply if you want to use conda environments you have defined,
for Python or R for example, in an interactive session launched from the Collab Portal.

### Jupyter Server

The Jupyter Server can be used with a pre-defined Python environment,
which you select from the "Environment type" dropdown menu 
that appears as you configure the session.

To use your own previously created conda environment within a Jupyter Server session,
select instead "Use custom text field", which will contain 

```
module load anaconda3
```

For this to work, the `ipykernel` package must be installed into your environment beforehand.
To do this, within a terminal session execute the following:

```
conda activate <environment>
conda install -y ipykernel
ipython kernel install --user --name=<environment>
```

When the session begins, your environment is displayed in the kernel list.

### RStudio 

Likewise, RStudio can be used with a default environment,
selected from the "Environment selection" dropdown menu.
Furthermore, when the session starts,
additional R packages can be installed from an extensive list.

But if you want to use your own custom environment within an RStudio session,
select instead "Use custom text field", and enter the following text:

```
module load anaconda
conda activate <environment>
export CONDAENVLIB=~/.conda/envs/<environment>/lib
export LD_LIBRARY_PATH=$CONDAENVLIB:$LD_LIBRARY_PATH
```

Notes:

- The export commands help RStudio load some libraries 
while accessing the conda environment's R installation. 
- The default location of conda environments is `~/.conda/envs`.
If your environment is installed somewhere else, 
`CONDAENVLIB` should be set accordingly. 

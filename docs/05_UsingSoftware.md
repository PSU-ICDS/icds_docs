

# Using Software


The software stack on Roar provides a wide variety of software to the entire user community. 
There are two software stacks available.

- **System software stack**: contains software that is available to all users by default upon logging into the system without a need to load anything.
- **Central software stack**: contains software that is available to all users by default, but the software modules must be loaded to access them.


## Modules

The central software stack uses [Lmod](https://lmod.readthedocs.io/en/latest/) to package the available software. 
Lmod is a useful tool for managing user software environments using environment modules that can be dynamically added or removed using module files. 
Lmod is hierarchical, so sub-modules can be nested under a module that is dependent upon. 
Lmod alters environment variables, most notably the `$PATH` variable, in order to make certain software packages reachable by the user environment.


### Useful Lmod Commands

| Command | Description |
| ---- | ---- |
| `module avail` | List all modules that are available to be loaded |
| `module show <module_name>` | Show the contents of a module |
| `module spider <module_name>` | Search the module space for a match |
| `module load <module_name>` | Load module(s) |
| `module load <module>/<version>` | Load a module of a specific version |
| `module unload <module_name>` | Unload module(s) |
| `module list` | List all currently loaded modules |
| `module purge` | Unload all currently loaded modules |
| `module use <path>` | Add a path to `$MODULEPATH` to expand module scope |
| `module unuse <path>` | Remove a path from `$MODULEPATH` |


The central software stack is available to the user environment by default since the `$MODULEPATH` environment variable is set and contains the central software stack location. 
Modules can be directly loaded with

```
$ module load <package>
```

To see the available software modules, use
```
$ module avail
```


## Custom Software

Although a large variety of software packages are available via the system and central software stacks, users may need access to additional software. 
Users may also wish to have greater control over the software packages that are required for their research workflow.


### Custom Modules

Users can install custom software packages and build custom software modules to build a custom user- or group-specific software stack. 
For users and groups with well-defined research workflows, it is recommended to create a custom software stack to keep close control of the software installation versions and configuration. 
A location should be specified that contains the custom software installations and the module files for the custom software installations should be stored together in a common location. 
This module location can be added to the `$MODULEPATH` environment variable so users can access the software modules just as they would for the central software stack. 
The [Lmod](https://lmod.readthedocs.io/en/latest/) documentation contains more detailed information on creating custom software modules.


### Anaconda

[Anaconda](https://docs.anaconda.com/index.html) is a very useful package manager that is available on Roar. 
Package managers simplify software package installation and manage dependency relationships while increasing both the repeatability and the portability of software. 
The user environment is modified by the package manager so the shell can access different software packages. 
Anaconda was originally created for Python, but it can package and distribute software for any language. 
It is usually very simple to create and manage new environments, install new packages, and import/export environments. 
Many packages are available for installation through Anaconda, and it enables retaining the environments in a silo to reduce cross-dependencies between different packages that may perturb environments.

Anaconda can be loaded from the software stack on RC with the following command:
```
$ module load anaconda
```

Usage of Anaconda may cause storage quota issues since environments and packages are stored within `~/.conda` by default. 
This issue can be easily resolved by moving the `~/.conda` directory to the work directory and creating a link in its place pointing to the new location in the work directory. 
This is described further in the [Handling Data](04_HandlingData.md) section on [Managing Large Configuration Files](04_HandlingData.md/#managing-large-configuration-files).


#### Installation Example

After loading the **anaconda** module, environments can be created and packages can be installed within those environments. 
When using the **anaconda** module for the first time on a system, the `conda init bash` command may be required to initialize anaconda, then a new session must be started for the change to take effect. 
In the new session, the command prompt may be prepended with `(base)` which denotes that the session is in the base anaconda environment.

To create an environment that contains both **numpy** and **scipy**, for example, run the following commands:

```
(base) $ conda create -n py_env
(base) $ conda activate py_env
(py_env) $ conda install numpy
(py_env) $ conda install scipy
```

Note that after the environment is entered, the leading item in the prompt changes to reflect the current environment.

Alternatively, the creation of an environment and package installation can be completed with a single line.

```
(base) $ conda create -n py_env numpy scipy
```

For more detailed information on usage, check out the [Anaconda documentation](https://docs.conda.io/projects/conda/en/latest/index.html).


#### Useful Anaconda Commands

| Command | Description |
| ---- | ---- |
| `conda create –n <env_name>` | Creates a conda environment by name |
| `conda create –p <env_path>` | Creates a conda environment by location |
| `conda env list` | Lists all conda environments |
| `conda env remove –n <env_name>` | Removes a conda environment by name |
| `conda activate <env_name>` | Activates a conda environment by name |
| `conda list` | Lists all packages within an active environment |
| `conda deactivate` | Deactivates the active conda environment |
| `conda install <package>` | Installs a package within an active environment |
| `conda search <package>` | Searches for a package |
| `conda env export > env_name.yml` | Exports active environment to a file |
| `conda env create –f env_name.yml` | Loads environment from a file |


#### Submission Script Usage

Slurm does not automatically source the `~/.bashrc` file in your batch job, so Anaconda may not be properly initialized within Slurm job submission scripts. 
Fortunately, the **anaconda** modules on the software stack initialize the software so that the `conda` command is automatically available within the Slurm job submission script. 
If using a different anaconda installation, this issue can be resolved by directly sourcing the `~/.bashrc` file in your job script before running any conda commands:

```
source ~/.bashrc
```

Alternatively, the environment can be activated using `source` instead of `conda`.

```
source activate <environment>
```

Another way to resolve this is to add the following shebang to the top of a Slurm job script:

```
#!/usr/bin/env bash -l
```

Yet another option would be to put the following commands before activating the conda environment:

```
module load <custom anaconda module>
CONDAPATH=`which conda`
eval "$(${CONDAPATH} shell.bash hook)"
```

To reiterate, the **anaconda** modules available on the software stack are configured such that the `conda` command is automatically available within a Slurm job submission script. 
The above options are only necessary for other anaconda installations.


#### Using Conda Environments in Interactive Apps

Environments built with Anaconda can be used in Interactive Apps on the Roar Portals as well. 
Typically the environment should be created and configured in an interactive compute session, and then some additional steps are needed to make the environment available from within an Interactive App.


##### Jupyter Server

To access a conda environment within a Jupyter Server session, the *ipykernel* package must be installed within the environment. 
To do so, enter the environment and run the following commands:

```
(base) $ conda activate <environment>
(<environment>) $ conda install -y ipykernel
(<environment>) $ ipython kernel install --user --name=<environment>
```

After the *ipykernel* package is successfully installed within this environment, a Jupyter Server session can be launched via the Roar Portal. 
When submitting the form to launch the session, under the *Conda environment type* field, select the *Use custom text field* option from the dropdown menu. 
Then enter the following into the *Environment Setup* text field:

```
module load anaconda
```

After launching and entering the session, the environment is displayed in the kernel list.


##### RStudio

To launch an RStudio Interactive App session, RStudio must have access to an installation of R. 
R can either be installed within the conda environment itself, or it can be loaded from the software stack. 
Typically, R will be installed by default when installing R packages within a conda environment; therefore, it is recommended when using conda environments within RStudio to simply utilize the environment's own R installation. 
To create an environment containing an R installation, run the following command:

```
(base) $ conda create -y -n <environment> r-base
```

Alternatively, R can simply be added to an existing environment by entering that environment and installing using the following command:

```
(<environment>) $ conda install r-base <plus any additional R packages>
```

R packages can installed directly via Anaconda within the environment as well. 
R packages available in Anaconda are usually named `r-<package name>` such as `r-plot3d`, `r-spatial`, or `r-ggplot`.

After R and any necessary R packages are installed within the environment, an RStudio session can be launched via the Roar Portal. 
When submitting the form to launch the session, under the *Environment type* field, select the *Use custom text field* option from the dropdown menu. 
Then enter the following into the *Environment Setup* text field:

```
module load anaconda
conda activate <environment>
export CONDAENVLIB=~/.conda/envs/<environment>/lib
export LD_LIBRARY_PATH=$CONDAENVLIB:$LD_LIBRARY_PATH
```

Please note that the default location of conda environments is in `~/.conda/envs`, which is why the `CONDAENVLIB` variable is being set to `~/.conda/envs/<environment>/lib`. 
If the environment is instead installed a non-default location, then the `CONDAENVLIB` variable should be set accordingly. 
The two `export` commands in the block above are required because RStudio often has an issue loading some libraries while accessing the conda environment's R installation. 
Explicitly adding the conda environment's *lib* directory to the `LD_LIBRARY_PATH` variable seems to clear up this issue.


### Compiling From Source

Compiling software from source is the most involved option for using software, but it gives the user the highest level of control. 
Research computing software is often developed by academic researchers that do not place a large effort on packaging their software so that it can be easily deployed on other systems. 
If the developer does not package the software using a package manager, then the only option is to build the software from source. 
It is best to follow the installation instructions from the developer to successfully install the software from source.

It is recommended to build software on a node with the same processor type that will be used for running the software. 
On a compute node, running the following command displays the processor type:

```
$ cat /sys/devices/cpu/caps/pmu_name
```

Software builds are not typically back-compatible and will not run successfully on processors older than the processor used to build. 
It is recommended to build on haswell (the oldest processor architecture on Roar) if you wish to have full compatibility across any Roar compute node. 
To optimize for performance, however, build on the same processor on which the software runs.

    | Release Date | Processor |
    | :----: | :----: |
    | 2013 | haswell |
    | 2014 | broadwell |
    | 2015 | skylake |
    | 2019 | cascadelake |
    | 2019 | icelake |
    | 2023 | sapphirerapids |


### Containers

A container is a standard unit of software with two modes:

1. Idle: When idle, a container is a file that stores everything an application (or collection of applications) requires to run (code, runtime, system tools, system libraries and settings).
2. Running: When running, a container is a Linux process running on top of the host machine kernel with a user environment defined by the contents of the container file, not by the host OS.

A container is an abstraction at the application layer. 
Multiple containers can run on the same machine and share the host kernel with other containers, each running as isolated processes.

Apptainer is a secure container platform designed for HPC use cases and is available on Roar. 
Containers (or images) can either be pulled directly from a container repository or can be built from a definition file. 
A definition file or recipe file contains everything required to build a container. 
Building containers requires root privileges, so containers are built on your personal device and can be deployed on Roar. Alternatively, users can utilize the `--fakeroot` option to build containers without root privileges, and the usage of this method is described in Apptainer's documentation of the [fakeroot feature](https://apptainer.org/docs/user/main/fakeroot.html#usage).

Software is continuously growing in complexity which can make managing the required user environment and wrangling dependent software an intractable problem. 
Containers address this issue by storing the software and all its dependencies (including a minimal operating system) in a single image file, eliminating the need to install additional packages or alter the runtime environment. 
This makes the software both shareable and portable while the output becomes reproducible.

In a Slurm submission script, a container can be called serially using the following run line:

```
$ apptainer run <container> <args>
```

To use a container in parallel with MPI, the MPI library within the container must be compatible with the MPI implementation on the system, meaning that the MPI version on the system must generally be newer than the MPI version within the container. 
More details on using MPI with containers can be found on Apptainer's [Apptainer and MPI Applications](https://apptainer.org/docs/user/1.0/mpi.html) page. 
In a Slurm submission script, a container with MPI can be called using

```
$ srun apptainer exec <container> <command> <args>
```

Containers change the user space into a swappable component, and provide the following benefits:

- Flexibility: Bring your own environment (BYOE) and bring your own software (BYOS)
- Reproducibility: Complete control over software versions
- Portability: Run a container on your laptop or on HPC systems
- Performance: Similar performance characteristics as native applications
- Compatibility: Open standard that is supported on all major Linux distributions


#### Container Registries

Container images can be made publicly available, and containers for many use cases can be found at the following container registries:

- [Docker Hub](https://hub.docker.com/)
- [Singularity Hub](https://singularityhub.github.io/singularityhub-docs/)
- [Singularity Cloud Library](https://cloud.sylabs.io/library)
- [NVIDIA GPU Cloud](https://ngc.nvidia.com/catalog/containers)
- [Quay.io](https://quay.io/)
- [BioContainers](https://biocontainers.pro/)


#### Useful Apptainer Commands

| Command | Description |
| ---- | ---- |
| `apptainer build <container> <definition>` | Builds a container from a definition file |
| `apptainer shell <container>` | Runs a shell within a container |
| `apptainer exec <container> <command>` | Runs a command within a container |
| `apptainer run <container>` | Runs a container where a runscript is defined |
| `apptainer pull <resource>://<container>` | Pulls a container from a container registry |
| `apptainer build --sandbox <sbox> <container>` | Builds a sandbox from a container |
| `apptainer build <container> <sbox>` | Builds a container from a sandbox |


#### Building Container Images

Containers can be made from scratch using a [definition file](https://apptainer.org/docs/user/latest/definition_files.html#definition-files), or recipe file, which is a text file that specifies the base image, the software to be installed, and other information. 
The `apptainer build` command's [documentation](https://apptainer.org/docs/user/main/cli/apptainer_build.html) shows the full usage for the build command. 
Container images can also be bootstrapped from other images, found on Docker Hub for instance.

The recommended workflow for building containers is shown below:

<center>
![Recommended container workflow.](img/ContainerWorkflow.png)
</center>



## Software-Specific Guides




### Python

Python is a high-level, general-purpose programming language.


#### Python versions

Python is available by default to all users on the system software stack, and it is also available on the central software stack. 
Additionally, users can install their own instances of Python in a variety of ways in either their userspace or in group spaces.


#### Install Python Packages with `pip`

Python packages can be installed easily using `pip`. 
By default, `pip` will attempt to install packages to a system location.
On shared systems, however, users do not have write access to system locations. 
The packages can instead be installed in *~/.local*, which is a user location, using the following:

```
$ pip install --user <package>
```

Also, packages can be installed to a custom specified location using the `--target` option:

```
$ pip install --target=<install_dir> <package>
```

Note that if `pip` is not available, simply try `pip3` (for python3) or `pip2` (for python2) instead.


### R

R is a free software environment for statistical computing and graphics.


#### R Versions

R users should make sure that the version of R remains consistent. 
Several R versions are available, and when a package is installed in one version, it is not always accessible when operating in another version. 
Always check the R version and remain consistent! 
R modules can be loaded from the central software stack, and R can also be installed by users in a variety of ways within their userspace or group spaces.


#### Install R Packages

R manages some dependencies and versions through the CRAN-like repos. 
R packages can be installed from within the R console with the following command:

```
> install.packages( <package> )
```

Upon running the install command, a warning usually appears stating that the default system install location is not writable, so it asks to install in a personal library instead. 
After entering "yes" as a response, it may then ask to create a personal library location. 
Responding "yes" again will proceed with the installation, probably by asking to select a CRAN repository.

The default personal directory described above will install the package within the `~/R/` directory. 
An install location can instead be supplied to the install command using the `lib` argument:

```
> install.packages( "<package>", lib="<install_location>" )
```

After installation, packages can then be loaded using the following command in the R console:

```
> library( <package> )
```

If the package was installed in a non-standard location, then the package can be loaded from that custom install location using the `lic.loc` argument of the `library()` command:

```
> library( <package>, lib.loc="<install_location>" )
```

Another method to specify package installation locations for R is to modify the `R_LIBS` environment variable before launching an R console session. 
If RStudio is being used, though, the `R_LIBS_USER` environment variable must be modified before launching RStudio. 
Modifying these environment variables properly can eliminate the need to use the `lib.loc` option of R's `library()` command.

It is recommended to review dependencies of any packages to be installed because additional software may have to be loaded in the environment before launching the R console. 
For example, some R packages utilize CMake to perform the installation. 
In that case, the *cmake* module should be loaded before launching the R console session.


#### R Package Installation Example

To install the ggplot2 R package, first search ggplot2 online to see if there are installation instructions. 
A quick search shows that ggplot2 is included in the tidyverse package and that the recommended installation instructions are the following:

```
# The easiest ways to get ggplot2 is to install the whole tidyverse package:
> install.packages("tidyverse")

# Alternatively, install just ggplot2:
> install.packages("ggplot2")
```

Searching for install instructions usually provides all the necessary information!

Some R packages may require changes to the user environment before the package can be installed successfully within the R console. 
Typically, the user environment change is as simple as accessing a newer compiler version by loading a software module like *intel* with

```
$ module load intel
```

Sometimes, installing R packages may be a little more involved. 
To install the *units* R package, for example, an additional library must be downloaded and installed locally for the package to be installed properly. 
To install the *units* R package for R version 4.2.1, perform the following commands in an interactive session on a compute node:

```
$ cd ~/scratch
$ wget https://downloads.unidata.ucar.edu/udunits/2.2.28/udunits-2.2.28.tar.gz
$ tar -xvf udunits-2.2.28.tar.gz
$ cd udunits-2.2.28
$ ./configure prefix=$HOME/.local
$ make
$ make install
$ export UDUNITS2_INCLUDE=$HOME/.local/include
$ export UDUNITS2_LIBS=$HOME/.local/lib
$ export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
$ module load r/4.2.1
$ R
> install.packages("units")
> library(units)
```


#### R Packages with Anaconda

The R installation itself and its R packages can be easily installed and managed within a conda environment. 
Creating a conda environment containing its own R installation and some R packages can be accomplished with the following:

```
(base) $ conda create -n r_env
(base) $ conda activate r_env
(r_env) $ conda install r-base
(r_env) $ conda install r-tidyverse
```

Note that after `r-base` is the base R installation, and R packages (or in the case of `tidyverse`, a bundle of packages) usually are named `r-*` in conda repos.

Alternatively, the creation of this environment can be completed with a single line.

```
(base) $ conda create -n r_env r-base r-tidyverse
```


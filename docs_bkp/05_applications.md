---
title: Software on Roar
---

# Using Software Modules

Software modules are an efficient way for ICDS systems personnel to deliver a wide array of software packages to the user community without placing extraneous clutter in the users' environments. Software modules can be loaded to and unloaded from a user's environment in a straightforward and simple manner, whether in an interactive manner or in a batch job. Loading a module makes module-specific, reversible changes to the user's shell environment, which allows modules to be loaded and unloaded at the user's will without creating increasingly complex user environments. These environment changes occur in a dynamically without the need to reload or reset the environment. Learn more about modules on [TACC’s website](https://www.tacc.utexas.edu/research-development/tacc-projects/lmod)


All modules, available versions, and defualt versions on the software stack are viewed and loaded with the following commands:

```
$ module avail
$ module load <module_name>
```

Some research software has multiple versions available to users. If no version is specified, then the default version will be loaded. To load the default version module of a module, in this case Matlab, no version number is necessary. A specific software version can be specified by including the version number while loading the module. Version specification is only pertinent if multiple versions of a specific software module are available. The software stack is periodically updated, so specifying a version number will ensure reproducibility across these software updates.  

```
$ module load matlab

$ module load matlab/R2022a
```

For more information on available module versions or to check a specific module 
```
$ module spider gcc

```

Some modules shown may contain submodules that will be shown as available if the parent module is loaded. For example, the default GCC module is gcc/8.3.1 and contains numerous submodules. The submodules are available to be loaded once the parent module is loaded.

```
$ module load gcc
$ module avail
```


To view all modules that are currently loaded in the environment, use the following command:
```
$ module list
```

A specific module can be unloaded or all of the modules can be purged with the following commands, respectively:
```
$ module unload gcc
$ module purge
```

For a complete description of the changes a module makes to the environment, such as the altering environment variables, and also for a brief description and contextual information about a module, the following command can be used:
```
$ module show gcc
```


## Central Software Stack


Many common research software packages are already installed and available for Roar users. Most of this software is installed on the Roar software stack as software modules which can be loaded and unloaded with relative ease. Be sure to reserve compute nodes and/or processors to run research sofware because running computationally expensive software on submit nodes will drastically reduce computing performance.



## RISE Software Stack


If a software package or a specific version is not available on the main software stack, it may be available in the RISE software stack which is also accessible to Roar users. After specifying this alternate software location, the modules in the RISE software stack are accessible just like any module on the main software stack.

```
$ module use /gpfs/group/RISE/sw7/modules
$ module avail
```


The RISE software stack can then be unloaded with the following command:
```
$ module unload /gpfs/group/RISE/sw7/modules
```


# User Software

Users may install software in work and group spaces. ICDS strongly recommends that research groups install software in group spaces to ensure version consistency and reproducibility. The iASK Center can provide guidance for the installation of many software packages.


## Custom Modules

As mentioned previously, environment modules provide a convenient way to dynamically change a user's environment through modulefiles. This includes easily adding or removing directories to the `PATH`, `LD_LIBRARY_PATH`, `MANPATH`, and `INFOPATH` environment variables. A modulefile contains the necessary information to allow a user to run a particular application or provide access to a particular library. Modulefiles for applications modify the users path to make access easy, and for library packages, modulefiles provide environment variables that specify where the library and header files can be found. Users are encouraged to create their own custom modulefiles whenever necessary to enable simple use cases for user-specific software.


## Anaconda Environments

For many software packages, managing dependencies and interoperability between the required packages can be a monumental task. Creating environments using package managers is highly recommended for cases with numerous dependencies, and Anaconda is typically preferred. Anaconda can be loaded with the following command:
```
$ module load anaconda3
```

An [Anaconda cheatsheet](https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf) is available directly from Anaconda and covers the basic creation, management, and functionality of conda environments.


## Containers

Apptainer is a *container* system developed for use on high-performance computing clusters. Container computing allows the creation of a virtual-machine-like environment, which gives the user access to different configurations of software for use on clusters.

Using Singularity to install a container on Roar can help users:

*   avoid dependence challenges
*   perform the same expected behavior on local and remote systems
*   easily move containers to new locations

This may help if you need to run a container without having sudo access, but keep in mind that the container must integrate seamlessly into the existing destination infrastructure.



### Getting Started with Apptainer

Before getting started with using Apptainer on Roar, install Apptainer on a system for which you have root access. Building a container from a recipe file must be done using sudo priveleges, hence the need for a machine with root access.

Note: Docker Integration
Apptainer supports Docker natively and directly. This means that nearly all Docker images can be used directly as long as the required functionality does not require root access; however, most applications do not require this. We provide an example in the next section, Obtaining pre-built images.


### Obtaining Pre-Built Images


Images built by others users, sometimes the developers of the desired software itself, are among the best choices for a base image and, in many cases, may be all a researcher needs to do to have an image that gives the desired outcome.

We can note the first issue, the non-existent bind paths. For this type of image, add the bind paths by slightly modifying the images. This can be done by writing a simple set of instructions, which are used to create an image. This set of instructions is called a recipe, in Singularity terminology.



### Handling the Bind Paths on Roar

In order to handle the bind paths, it is very helpful to start with a recipe to set the data paths, even if the image is mostly a prepared image from another source. Start with a recipe and add the correct binding paths for Roar. The following is a simple example to handle the bind points using the lolcow image:

```
<pre class="script">BOOTSTRAP: docker
FROM: godlovedc/lolcow
%post
#ACI mappings so you can access your files.
mkdir -p /storage/home
mkdir -p /storage/work
mkdir -p /gpfs/group
mkdir -p /gpfs/scratch
mkdir -p /var/spool/torque
```


The image must be built in an environment that has sudo access, not on Roar:

```
<pre class="script">[cjb47@localhost simple_bind]$ sudo singularity build ./lolcow.simg ./lolcow.recipe
Building into existing container: ./lolcow.simg
Using container recipe deffile: ./lolcow.recipe
Sanitizing environment
Adding base Singularity environment to container
Running post scriptlet
+ mkdir -p /storage/home
+ mkdir -p /storage/work
+ mkdir -p /gpfs/group
+ mkdir -p /gpfs/scratch
+ mkdir -p /var/spool/torque
Found an existing definition file
Adding a bootstrap_history directory
Finalizing Singularity container
Calculating final size for metadata...
Skipping checks
Building Singularity image...
Singularity container built: ./lolcow.simg
Cleaning up...
```


### Ways of using Singularity containers

Once a container has been built and is placed on Roar, you can use it in a variety of ways. Here, we explain a few ways, including:

*   Roar interactive sessions
*   Roar batch sessions

*   Interactive shells
*   Executing commands
*   Running a container
*   Working with files


Working with Files:

As long as there are corresponding binding points, you will be able to reach files on the host from within the container. Since Roar has user storage in non-standard locations (compared to distribution default), you will need to add the appropriate locations to a recipe.

In the following example, we need binding for Roar:

```
<pre class="script">%post
#ACI mappings so you can access your files.
mkdir -p /storage/home
mkdir -p /storage/work
mkdir -p /gpfs/group
mkdir -p /gpfs/scratch
mkdir -p /var/spool/torque
```

### More information on building Singularity containers

The official [Apptainer User Guide](https://apptainer.org/docs/user/main/) has additional information and examples related to building and using Singularity containers.


Following are several other use cases:

*   Building containers with GUI support
*   Building an image with MPI support
*   Images with GPU support
*   Running Services
*   Using sandbox and writable images


## Compiling





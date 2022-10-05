---
title: Software on Roar
---


## Using Software Modules

All modules, available versions, and defualt versions on the software stack are viewed and loaded with the following commands:

```
$ module avail
$ module load <module_name>
```

Some research software has multiple versions available to users. If no version is specified, then the default version will be loaded. To load the default version module of a module, in this case Matlab, no version number is necessary. A specific software version can be specified by including the version number while loading the module. Version specification is only pertinent if multiple versions of a specific software module are available. The software stack is periodically updated, so specifying a version number will ensure reproducibility across these software updates.  

```
$ module load matlab
$ module load matlab/R2020a
```

Some modules shown may contain submodules that will be shown as available if the parent module is loaded. For example, the default GCC module is gcc/8.3.1 and contains numerous submodules. The submodules are available to be loaded once the parent module is loaded.

```
$ module load gcc
$ module avail
```

Describe these functionalities:
```
$ module list
$ module spider
$ module show
```


### Central Software Stack

Many common research software packages are already installed and available for Roar users. Most of this software is installed on the Roar software stack as software modules which can be loaded and unloaded with relative ease. Be sure to reserve compute nodes and/or processors to run research sofware because running computationally expensive software on submit nodes will drastically reduce computing performance.


### RISE Software Stack

If a software package or a specific version is not available on the main software stack, it may be available in the RISE software stack which is also accessible to Roar users. After specifying this alternate software location, the modules in the RISE software stack are accessible just like any module on the main software stack.

```
$ module use /gpfs/group/RISE/sw7/modules
$ module avail
```




## User Software

Users are able to install software into their own home and work directories as well as in group spaces. ICDS strongly recommends that research groups who compute in multiple locations do this for all of their software so that the version can be consistent across platforms. The i-ASK Center can provide guidance for the installation of many software packages.


### Custom Modules

Roar now uses the Lmod environment modules system. Environment Modules provide a convenient way to dynamically change the users environment through modulefiles. This includes easily adding or removing directories to the `PATH`, `LD_LIBRARY_PATH`, `MANPATH`, and `INFOPATH` environment variables. A modulefile contains the necessary information to allow a user to run a particular application or provide access to a particular library. All of this can be done dynamically without logging out and back in. Modulefiles for applications modify the users path to make access easy. Modulefiles for library packages provide environment variables that specify where the library and header files can be found. Learn more about modules on [TACC’s website](https://www.tacc.utexas.edu/research-development/tacc-projects/lmod).


### Anaconda Environments




### Containers

Singularity is a _container_ system developed for use on high-performance computing clusters. Container computing allows the creation of a virtual-machine-like environment, which gives the user access to different configurations of software for use on clusters.

Using Singularity to install a container on Roar can help users:

*   avoid dependence challenges
*   perform the same expected behavior on local and remote systems
*   easily move containers to new locations

This may help if you need to run a container without having sudo access, but keep in mind that the container must integrate seamlessly into the existing destination infrastructure.

8.3.7.1 Getting Started with Using Singularity

Before getting started with using Singularity on Roar, you will need to install Singularity on a system for which you have root access. [Singularity’s official user guide](https://www.sylabs.io/docs/) provides instructions for doing this. Roar uses version 2.6.0 of Singularity.

Note: Docker Integration
Singularity supports Docker natively and directly. This means that nearly all Docker images can be used directly as long as the required functionality does not require root access; however, most applications do not require this. We provide an example in the next section, Obtaining pre-built images.

9.3.7.3 Obtaining Pre-built Images

Images built by others users, sometimes the developers of the desired software itself, are among the best choices for a base image and, in many cases, may be all a researcher needs to do to have an image that gives the desired outcome.

We can note the first issue, the non-existent bind paths. For this type of image, add the bind paths by slightly modifying the images. This can be done by writing a simple set of instructions, which are used to create an image. This set of instructions is called a recipe, in Singularity terminology.

9.3.7.4 Handling the Bind Paths on Roar

In order to handle the bind paths, it is very helpful to start with a recipe to set the data paths, even if the image is mostly a prepared image from another source. We will take a look at how to do this, and then discuss the building process in more detail.

We can also start with a recipe and add the correct binding paths for ACI-b. Here is a simple example to handle the bind points using the lolcow image.

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

We build the image in an environment where we have sudo access (not Roar):
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


9.3.7.5 Ways of using Singularity containers

Once a container has been built and is placed on Roar, you can use it in a variety of ways. Here, we explain a few ways, including:

*   ACI-b interactive sessions
*   ACI-n batch sessions
*   Interactive shells
*   Executing commands
*   Running a container
*   Working with files


Working with Files:

As long as there are corresponding binding points, you will be able to reach files on the host from within the container. Since Roar has user storage in non-standard locations (compared to distribution default), you will need to add the appropriate locations to a recipe.

In the following example, we need binding for ACI-b:
```
<pre class="script">%post
#ACI mappings so you can access your files.
mkdir -p /storage/home
mkdir -p /storage/work
mkdir -p /gpfs/group
mkdir -p /gpfs/scratch
mkdir -p /var/spool/torque
```

9.3.7.6 More information on building Singularity containers

The official [Singularity user guide](https://www.sylabs.io/guides/2.6/user-guide/) has additional information and examples related to building and using Singularity containers.

Following are several other use cases:

*   Building containers with GUI support
*   Building an image with MPI support
*   Images with GPU support
*   Running Services
*   Using sandbox and writable images



### Compiling



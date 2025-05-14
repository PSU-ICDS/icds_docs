# Using Containers on RC

## Overview

Containers address the growing issue of software and dependency complexity by storing the 
software and all its dependencies (including a minimal operating system) in a single image 
file, which runs on top of the host machine kernel - abstracting the application layer 
and defining the user environment.

Containers change the user space into a swappable component, and provide the following benefits:

- Flexibility: Bring your own environment (BYOE) and bring your own software (BYOS)
- Reproducibility: Complete control over software versions
- Portability: Run a container on your laptop or on HPC systems
- Performance: Similar performance characteristics as native applications
- Compatibility: Open standard that is supported on all major Linux distributions

If containers are new to you, we recommend the [Introduction to Containers on HPC 
lesson](https://pawseysc.github.io/hpc-container-training/) developed by the [Pawsey 
Supercomputer Centre](https://pawsey.org.au/).

Apptainer is a secure container platform designed for HPC use cases and is available on Roar. 

Containers (or images) can either be pulled directly from a container repository or can be 
built from a definition file. 

!!! warning "Building containers requires root privileges."
     Containers are built on your personal device and can be deployed on Roar. Alternatively, 
     the `--fakeroot` option can be used to build containers without root privileges as described in 
     Apptainer's documentation of the [fakeroot feature](https://apptainer.org/docs/user/main/fakeroot.html#usage).



## Using Containers with Slurm

In a Slurm submission script, a container can be called serially using the following run line:

```
$ apptainer run <container> <args>
```

To use a container in parallel with MPI, the MPI library within the container must be compatible 
with the MPI implementation on the system, meaning that the MPI version on the system must generally 
be newer than the MPI version within the container. 

More details on using MPI with containers can be found on Apptainer's [Apptainer and MPI Applications](https://apptainer.org/docs/user/1.0/mpi.html) page. 

In a Slurm submission script, a container with MPI can be called using

```
$ srun apptainer exec <container> <command> <args>
```


## Useful Apptainer Commands

| Command | Description |
| ---- | ---- |
| `apptainer build <container> <definition>` | Builds a container from a definition file |
| `apptainer shell <container>` | Runs a shell within a container |
| `apptainer exec <container> <command>` | Runs a command within a container |
| `apptainer run <container>` | Runs a container where a runscript is defined |
| `apptainer pull <resource>://<container>` | Pulls a container from a container registry |
| `apptainer build --sandbox <sbox> <container>` | Builds a sandbox from a container |
| `apptainer build <container> <sbox>` | Builds a container from a sandbox |



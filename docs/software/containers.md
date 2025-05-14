# Containers

Containers address the issue of software and dependency complexity 
by storing the software and its dependencies (including a minimal operating system) 
in a single image file, which runs on top of the host machine kernel.

Containers provide:

- Flexibility: Bring your own environment (BYOE) and bring your own software (BYOS)
- Reproducibility: Complete control over software versions
- Portability: Run on your laptop or on HPC systems
- Performance: Nearly as fast as as native applications
- Compatibility: Supported on most Linux distributions

For more information, see
[Introduction to Containers](https://pawseysc.github.io/hpc-container-training/) 
from the [Pawsey Supercomputer Centre](https://pawsey.org.au/).

Apptainer is a container platform available on Roar.
Containers can either be downloaded from a container repository
or built from a definition file. 

!!! warning "Building containers requires root privileges."
     Containers are built on your personal device and can be deployed on Roar. Alternatively, 
     the `fakeroot` option can be used to build containers on Roar without root privileges;
     see [fakeroot](https://apptainer.org/docs/user/main/fakeroot.html#usage).


## Containers with Slurm

In a Slurm batch script, a container can be launched with:

```
$ apptainer run <container> <args>
```

To use a container with parallel execution,
the system version of MPI must be newer than the container MPI library. 
See [Apptainer and MPI Applications](https://apptainer.org/docs/user/1.0/mpi.html). 

In a Slurm batch script, a container with MPI can be launched with:

```
$ srun apptainer exec <container> <command> <args>
```

## Apptainer commands

| Command | Description |
| ---- | ---- |
| `apptainer build <container> <definition>` | Builds a container from a definition file |
| `apptainer shell <container>` | Runs a shell within a container |
| `apptainer exec <container> <command>` | Runs a command within a container |
| `apptainer run <container>` | Runs a container where a runscript is defined |
| `apptainer pull <resource>://<container>` | Pulls a container from a container registry |
| `apptainer build --sandbox <sbox> <container>` | Builds a sandbox from a container |
| `apptainer build <container> <sbox>` | Builds a container from a sandbox |



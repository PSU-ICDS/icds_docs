# Using Containers

Containers address the issue of software and dependency complexity by storing the 
application, its dependencies, and a minimal operating system in a single, portable 
**image file**. This image runs directly on top of the host machine's Linux kernel, 
providing a lightweight, reproducible, and flexible computing environment.

Containers provide several key benefits for scientific computing:

- **Flexibility (BYOE/BYOS):** Bring your own environment and software stack, regardless 
of what's natively installed on the host system.
- **Reproducibility:** Guarantee the exact software versions and library dependencies 
used for your research results.
- **Portability:** Run the exact same image on your local machine or on large-scale HPC 
systems.
- **Performance:** Containers run with near-native application speed.
- **Compatibility:** Supported across most modern Linux distributions.

The container platform available on Roar is `apptainer` (formerly Singularity).

## Building Containers

### Using Containers vs. Building Containers

This guide focuses solely on **using and running** pre-built containers on Roar. 
Building a complex or customized container image is an advanced topic that is not covered 
comprehensively here.

### Notice on Building Containers

Building an Apptainer image from a definition file (``apptainer build <image> <definition>``) 
**cannot be done on Roar**. Building requires **root (administrative) privileges**, which 
are not available to non-administrative users on ICDS systems.

- You must build your containers on a dedicated, appropriate machine (e.g., your personal 
workstation or a cloud service) where you have full **root access**.
- After building, you can transfer the resulting .sif image file to Roar.

### Building and Sandbox Alternatives on Roar

While full image builds are restricted, Apptainer offers alternatives for development:

- **fakeroot:** The --fakeroot option allows you to perform some root-like operations 
(like installing packages) during a build process, but it is often insufficient for 
complex system-level configuration.
- **Sandbox Directory:** You can build a writable "sandbox" directory from an existing 
container image for experimentation and modification:

```
apptainer build --sandbox <sandbox_directory> <container_image>
```

>[!WARNING]
>
> Use /tmp for sandbox or build directories.
>
>	Container build or sandbox directories **must not** use the 
>	**Scratch filesystem (/scratch/\$USER)**, as use of scratch may
>   result in container corruption. Use of the `/tmp` directory is
>   encouraged as an alternative.
>
>   When using `/tmp`, note that when the job ends, the `/tmp` directory
>   is automatically deleted.

## Container Discovery and Setup

Containers can either be downloaded from a public repository or transferred after being 
built elsewhere.

| Command | Description | Example |
| --- | --- | --- |
| `apptainer pull <resource>://<container>` | Downloads a container image from a remote registry (e.g., Sylabs Cloud, Docker Hub) and converts it to the native Apptainer (.sif) format. | `apptainer pull docker://ubuntu:20.04` |
| `apptainer shell <container>` | Runs an interactive shell inside the container for debugging or setup. | `apptainer shell my_image.sif` |
| `apptainer exec <container> <command>` | Executes a single command inside the container without dropping you into a shell. | `apptainer exec my_image.sif python script.py` |
| `apptainer run <container>` | Executes the container's predefined **runscript**, which is often the main application entry point. | `apptainer run my_app.sif --input data.txt` |

## Container and Host Filesystem Sharing

A notable feature of Apptainer on ICDS systems is that the container environment automatically **shares 
(binds)** several critical directories from the host system:

- Your Home directory: `/storage/home/\$USER`
- Your Work directory: `/storage/work/\$USER`
- Group directories: `/storage/group`
- The Scratch filesystem: `/scratch/\$USER`
- The temporary directory: `/tmp`

This seamless binding means you can read and write files directly between your containerized 
application and your standard HPC storage locations.

## Module Conflicts and Environment

When using containers, be aware of potential **module conflicts** with the host system:

- **Do not load environment modules on the host (Roar) that are intended to be used _inside_ 
the container.**
- This can lead to unexpected errors or the use of unintended or unexpected software versions.
	- For example, if you load an **R** module on the host system, the host's **R library path** will often 
be exposed to and prioritized by the container, overriding the container's built-in R 
libraries. 
- **Best Practice:** Run a `module purge` in your batch script _before_ starting the 
container to ensure a clean host environment.

## Containers with Slurm and MPI

**Running a Non-MPI Container**

The apptainer run or apptainer exec command is used directly in your Slurm batch script.

```
# !/bin/bash

# SBATCH --job-name=ContainerJob

# Run the containerized application
apptainer run /storage/work/\$USER/images/my_app.sif --input data.in
```

**Running Parallel (MPI) Applications**

To run parallel code, Apptainer must use the **host system's MPI library** and 
infrastructure to launch processes. This requires that the host MPI version be compatible 
with (and ideally newer than) the MPI library packaged inside the container.

Consult the **apptainer and MPI Applications** documentation for specific compatibility 
requirements.

```
# !/bin/bash
# SBATCH --job-name=MPIContainer
# SBATCH --ntasks=32

# Load the host's MPI module for process launching
module load openmpi/4.1.5

# Use srun with apptainer exec to launch a parallel command
srun --mpi=pmix apptainer exec /storage/work/\$USER/images/my_mpi_code.sif /usr/bin/my_parallel_executable
```
>[!NOTE]
>
>The container must be built using the same MPI as selected on the host via the module load.
>
>In this example, the container should be built with OpenMPI 4.1.5 with pmix support.
>
>If there is a version of mpi type mismatch, the job could lock up or run as a set of
>singleton jobs (multiple copies of a single processor job).
>

>[!WARNING]
>
>Due to the complexities of running containerized MPI jobs across nodes, it is recommended
>that you [first contact ICDS](mailto:idcs@psu.edu) for assistance prior to starting.
>

## Apptainer Cache

Apptainer automatically uses a directory `.apptainer`, located in your ***$HOME*** directory. As home directories on ICDS systems are small, you may wish to use an alternate location of the apptainer cache.

You can set this location via the environment variable ***APPTAINER_CACHEDIR***, setting it to an alternate location such as your ***WORK*** directory.

```
export APPTAINER_CACHEDIR=/storage/work/$USER
```

You should regularly clean your cache by running the command `apptainer cache clean`. 

>[!NOTE]
>
>You can first see what file will be cleaned by using the --dry-run option to the clean command.
>


## More Information

For a more comprehensive understanding of container technology and advanced usage, consider these external resources:

- **The Apptainer Documentation:** [The official user guide and full command reference.](https://apptainer.org/docs/user/main/quick_start.html)
- **HPC Carpentry / Code Refinery:** Look for tutorials on [containerization for scientific research](https://www.google.com/search?q=https://coderefinery.org/lessons/containers/) for hands-on, research-focused examples.
- **Pawsey Supercomputer Centre:** [Introduction to Containers](https://www.google.com/search?q=https://support.pawsey.org.au/documentation/display/US/Introduction%2Bto%2BContainers)

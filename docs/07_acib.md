---
title: Running Jobs on ACI-b
---

Jobs are submitted from the head nodes of ACI-b and will run when dedicated resources are available on the compute nodes. Roar uses Moab and Torque for the scheduler and resource manager. Jobs can be either run in batch or interactive modes. Both are submitted using the qsub command.  

  

#### 7.1 Requesting Resources

Both batch and interactive jobs are required to provide a list of requested resources to the scheduler in order to be placed on a compute node with the correct resources available. These are given either in the submission script or on the command line. If these are given in a submission script, they must come before any non-PBS command.  

Typical PBS directives are:

|PBS Directive|Description|
|--- |--- |
|#PBS -l walltime=HH:MM:SS|This specifies the maximum wall time (real time, not CPU time) that a job should take. If this limit is exceeded, PBS will stop the job. Keeping this limit close to the actual expected time of a job can allow a job to start more quickly than if the maximum wall time is always requested.|
|#PBS -l pmem=SIZEgb|This specifies the maximum amount of physical memory used by any processor ascribed to the job. For example, if the job would run on four processors and each would use up to 2 GB (gigabytes) of memory, then the directive would read #PBS -l pmem=2gb. The default for this directive is 1 GB of memory.|
|#PBS -l mem=SIZEgb|This specifies the maximum amount of physical memory used in total for the job. This should be used for single node jobs only.|
|#PBS -l nodes=N:ppn=M|This specifies the number of nodes (nodes=N) and the number of processors per node (ppn=M) that the job should use. PBS treats a processor core as a processor, so a system with eight cores per compute node can have ppn=8 as its maximum ppn request. Note that unless a job has some inherent parallelism of its own through something like MPI or OpenMP, requesting more than a single processor on a single node is usually wasteful and can impact the job start time.|
|#PBS -l nodes=N:ppn=M:O||

Node types available on Roar:  

|Node Type = O|CPU|RAM|
|--- |--- |--- |
|basic|Intel Xeon E5-2650v4 2.2GHz|128 GB Total|
|lcivybridge  
scivybridge|Intel Xeon E5-2680v2 2.8GHz|256 GB Total|
|schaswell|Intel Xeon E5-2680v3 2.5GHz|256 GB Total|
|himem|Intel Xeon E7-4830v2 2.2GHz|1024 GB Total|



##### <span class="titlemark">7.1.1</span> Sample Batch Submission Script

The following is a submission script for a Matlab job that will run for 5 minutes on one processor using the open queue.

```
#!/bin/bash

#PBS -l nodes=1:ppn=1

#PBS -l walltime=5:00

#PBS -A open

# Get started

echo "Job started on $(hostname) at $(date)"

# Load in matlab

module purge

module load matlab

# Go to the correct place

cd $PBS_O_WORKDIR

# Run the job itself - a matlab script called runThis.m

matlab-bin -nodisplay -nosplash < runThis.m > log.matlabRun

# Finish up

echo "Job Ended at $(date)"

```

This script would be submitted using the command

`qsub subScript.pbs`

from the directory containing the submission and matlab scripts.  

  

#### 7.2 Interactive Compute Sessions on ACI-b

Interactive jobs may be submitted to ACI-b using the -I (for interactive) flag. Interactive jobs require resource requests and an allocation. An interactive job can be submitted using a command similar to:

`qsub -A open -l walltime=1:00:00 -l nodes=1:ppn=2 -I`

The job will be given a job ID and your session will wait until this job has the resources to start. You will then be placed on the compute node and given a usable terminal session within your current session. For example a user submitting an interactive job may see

```
[abc123@aci-lgn-001 ~]$ qsub I l nodes=1:ppn=1 l walltime=4:00:00 -A open

qsub: waiting for job <span style="word-wrap: break-word;">2449840.torque01.util.production.int.aci.ics.psu.edu</span> u to start

qsub: job <span style="word-wrap: break-word;">2449840.torque01.util.production.int.aci.ics.psu.edu</span> ready

[abc123@comp-bc-0267 ~]$

```

Note that the node the user is on changes from log-in node (aci-lgn-001) to a basic core compute node (comp-bc-0267) when the job starts. You can ask for x-windows to be displayed using the `-X` flag with the `qsub` command, as long as you have logged into ACI-b using the `-Y` flag with `ssh`. Note that some users experiencing difficulty with interactive x-windows on ACI-b jobs will often use an Open OnDemand interactive session to connect to ACI-i, and then `ssh` with the `-Y` flag to ACI-b from ACI-i.  

It is recommended that you compile your code using an interactive job on the nodes that your job will run.  

  

#### 7.3 PBS Environmental Variables

Jobs submitted will automatically have several PBS environment variables created that can be used within the job submission script and scripts within the job. A full list of PBS environment variables can be used by viewing the output of

`env | grep PBS > log.pbsEnvVars`

run within a submitted job.

|Variable Name|Description|
|--- |--- |
|PBS_O_WORKDIR|The directory in which the qsub command was issued.|
|PBS_JOBID|The job's id.|
|PBS_JOBNAME|The job's name.|
|PBS_NODEFILE|A file in which all relevant node hostnames are stored for a job.|


##### <span class="titlemark">7.3.1</span> Viewing and Deleting Jobs

There are several ways to view existing jobs. The `qstat` command can give some basic information about your own queued and running jobs.

`qstat`

Some helpful flags are `-u` (user), `-s` (status), `-n` (to show the nodes running jobs are placed on) and -f to show more information for a specified job. For example, to view more information about job 536, you can use the command

`qstat -f 536`

Common status for jobs are Q for queued, R for running, E for ending, H for being held and C for complete.  

You can also view all of the jobs running, waiting and being held using the showq command:

`showq`

It may be helpful for you to view all of the jobs running on an allocation. For example, if you are a member of the abc123_a_g_sc_default allocation, you can view the running and queued jobs using the command:

`showq -w acct=abc123_a_g_sc_default`

You may delete your jobs using the qdel command. For example, the job 546 may be deleted using the command:

`qdel 546`

Jobs that are not responding may require being purged from the nodes. You can do this with the `-p` flag:

`qdel -p 546`

Note that you are only able to delete your own jobs, not other users.  

##### <span class="titlemark">7.3.2</span> Additional Job Information

You can use the checkjob command to view some additional information about queued and running jobs. For example, to give very verbose information about job 548, you can use the command:

`checkjob 548 -v -v`

  

#### 7.4 GReaT Allocations

All jobs submitted to an allocation that have available resources are guaranteed to start within 1 hour. Note that the resources include both available hours as well as the requested resources. For example, a group that has a 40 core allocations on two standard memory nodes is limited to the RAM and CPUs on both nodes. Single processor jobs that request most of the memory on the nodes may block other jobs from running, even if CPUs are idle.  

Users submitting to an allocation can run in ‘burst’ mode. Your group may use a number of cores up to four times your Core Limit (referred to as your 4x Core Limit). When your group submits jobs that exceed your Core Limit, you are considered to be ‘bursting,’ and your jobs will run on our Burst Queue. Bursting consumes your allocation faster than normal. How much you can burst is determined by your 90-day sliding window.  

How much you can use Roar is governed by the size of your allocation and how much you have used the system in the past 90 days. In any given 90-day period, you may use up to your Core Limit times the number of hours in 90 days (2160). The amount of core-hours you have available is governed by a 90-day sliding window, such that the core-hours you use in any given day become available again after 90 days.  

**How is My Allocation "Charged" for a Batch Job?**

The charge associated with a job is dependent on the total number of requested cores and the actual runtime of the job (in seconds):

NumberOfCores*Runtime.

For example, if a 20 core job has a total runtime of 1 hour the charge to the GReaT allocation is 20*3600=7200 core seconds. Please note that the charge includes the number of requested cores, not the number of utilized cores. Additionally, the requested walltime and actual runtime of the job may differ.

**Note:** In the tables below, run times are noted in hours to simplify the examples. In practice, allocations are charged for usage by the second.

<span class="cmbx-10">Example:</span> If you have a 20-core allocation, you can consume 43,200 (20 * 2160) core-hours within any given 90-day period. Your average rate of usage in any 90-day period cannot exceed 20 cores per hour. Core-hours you use on the first day of your allocation will become available again on the 91st day; core-hours you use on the second day become available again on the 92nd day; and so on. If you never burst, you can use all your cores continuously.  

<span class="cmbx-10">Example:</span> With your 20-core allocation, you run jobs requiring 20 cores continuously. In any given 90-day period, you will use 43,200 core-hours, and your average rate of usage is 20 cores per hour.

|Day|Core-Hours Available|Usage on this Day|Core-Hours Used This Day|
|--- |--- |--- |--- |
|1|43,200|20 cores x 24 hours|480|
|2|42,720|20 cores x 24 hours|480|
|3|42,240|20 cores x 24 hours|480|
|4|41,760|20 cores x 24 hours|480|


Usage continues at the same rate of 20 cores, 24 hours per day.

|Day|Core-Hours Available|Usage on this Day|Core-Hours Used This Day|
|--- |--- |--- |--- |
|90|480|20 cores x 24 hours|480|
|91|480|20 cores x 24 hours|480|
|92|480|20 cores x 24 hours|480|


Note that on Day 91, the core-hours used on Day 1 become available again; on Day 92, the core-hours used on Day 2 become available again; and so on.  

<span class="cmbx-10">Example:</span> Bursting above your allocation may lead to days with 0 hours available.

|Day|Core-Hours Available|Usage on this Day|Core-Hours Used This Day|
|--- |--- |--- |--- |
|1|43,200|20 cores x 24 hours|480|
|2|42,720|80 cores x 24 hours|1920|
|3|40,800|80 cores x 24 hours|1920|
|4|38,8801,760|80 cores x 24 hours|1920|


Usage continues at the same rate of 80 cores, 24 hours per day.

|Day|Core-Hours Available|Usage on this Day|Core-Hours Used This Day|
|--- |--- |--- |--- |
|24|480|60 cores x 8 hours|480|
|25|0|0|0|
|26|0|0|0|


At this point, no core-hours are available, and no jobs can be run against the allocation until Day 91, when the core-hours used on Day 1 become available again.

|Day|Core-Hours Available|Usage on this Day|Core-Hours Used This Day|
|--- |--- |--- |--- |
|91|480|20 cores x 24 hours|480|
|92|1920|0|0|
|93|3840|20 cores x 24 hours|480|


<span class="cmbx-10">Identifying Allocation Usage:</span>  

Users are able to see their allocations with the balance using the command mam-list-funds. This is typically used with the -h flag to show the allocation and balance in hours.

`mam-list-funds -h`

The allocation topology, end date and node-type can be shown using the mam-list-accounts command.

`mam-list-accounts`

Note that this shows you expired allocations as well. The second column (Active) will show True for active allocations and False for expired allocations.  

Users interested in their own usage may want to investigate several of the other mam commands:

`mam-list-usagerecords
mam-list-transactions
`

  

#### 7.5 ACI-b GPU nodes

The ACI-b GPU nodes are comprised of dual NVIDIA Tesla K80 GPU cards. Each card contains two GPUs that are individually schedulable. These nodes contain dual E5-2680 processors (24 total cores), and 256GB of RAM. For more information on this hardware, refer to [NVIDIA’s K80 specification document](https://www.nvidia.com/content/dam/en-zz/Solutions/Data-Center/tesla-product-literature/Tesla-K80-BoardSpec-07317-001-v05.pdf).

##### <span class="titlemark">7.5.1</span> Accessing GPU Resources

To access a GPU on ACI-b, you must be a member of a GReAT GPU allocation. To request a node with a GPU, add _"gpus=N"_ to your resource list in either your job script or a submission argument. For example, `#PBS -l nodes=1:ppn=1:gpus=1` or `qsub -l nodes=1:ppn=1:gpus=1 ...`  
The requested GPU is placed in exclusive process mode by default. This means that only a single process can access the GPU, but it can spawn multiple different threads. To allow multiple processes on a single GPU, the "shared" feature can be appended to the resource list. A general GPU request then takes the form of:  
`#PBS -l nodes=NN:ppn=NC:gpus=NG:feature`  
or  
`qsub -l nodes=NN:ppn=NC:gpus=NG:feature`  
Where:

*   NN = the number of nodes
*   NC = the number of cores per node
*   NG = the number of GPUS per node
*   feature = shared or is not included

**GPU job script example**  
Here is an example GPU job script that requests a single GPU and simply calls nvidia-smi:

```
#!/bin/bash
#PBS -l nodes=1:ppn=1:gpus=1
#PBS -l walltime=2:00
#PBS -l pmem=1gb
#PBS -A gpu_allocation_name

# Get started
echo " "
echo "Job started on `hostname` at `date`"
echo " "

# Go to the submission directory
cd $PBS_O_WORKDIR

# Run the main job commands
nvidia-smi

# Finish up
echo " "
echo "Job Ended at `date`"
```

##### <span class="titlemark">7.5.2</span> GPU Monitoring

You may want to monitor the status of a node’s GPU. The nvidia-smi command provides basic monitoring capabilities and will provide information such as GPU and memory utilization, power consumption, running processes, etc. Example output for this command:

```
$ nvidia-smi
Mon Oct  8 15:03:53 2018
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 390.30                 Driver Version: 390.30                    |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Tesla K80           Off  | 00000000:05:00.0 Off |                    0 |
| N/A   41C    P0    63W / 149W |      0MiB / 11441MiB |      0%   E. Process |
+-------------------------------+----------------------+----------------------+
|   1  Tesla K80           Off  | 00000000:06:00.0 Off |                    0 |
| N/A   36C    P0    71W / 149W |      0MiB / 11441MiB |      0%   E. Process |
+-------------------------------+----------------------+----------------------+
|   2  Tesla K80           Off  | 00000000:84:00.0 Off |                    0 |
| N/A   40C    P0    59W / 149W |      0MiB / 11441MiB |      0%   E. Process |
+-------------------------------+----------------------+----------------------+
|   3  Tesla K80           Off  | 00000000:85:00.0 Off |                    0 |
| N/A   32C    P0    75W / 149W |      0MiB / 11441MiB |     81%   E. Process |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```

##### <span class="titlemark">7.5.3</span> CUDA

NVIDIA has developed a parallel computing platform and programming model to facilitate the use of GPUs in general computing. This comes in the form of both GPU-accelerated libraries as well as programming extensions for C, C++, and Fortran (PGI compilers). CUDA 8.0, 9.0, and 9.1 are installed on the gpu nodes at /usr/local. To set up your shell environment, the CUDA bin and lib64 directories need to be added to PATH and LD_LIBRARY_PATH.  
`$ export PATH=/usr/local/cuda-9.1/bin:$PATH  
$ export LD_LIBRARY_PATH=/usr/local/cuda-9.1/lib64:$LD_LIBRARY_PATH  
`  
**CUDA example**  
The CUDA Toolkit includes many CUDA code examples that can help get you started with writing your own CUDA-enabled software. These examples can be found at /usr/local/cuda/samples/ for the latest available version of CUDA. You may also find [additional CUDA code samples](https://developer.nvidia.com/cuda-code-samples "CUDA code samples") on the NVIDIA website.  
Here, we will compare the performance of the CPU and GPU for the "nbody" example.

1.  Start an interactive session on a GPU node  
    `$ qsub -I -A gpu_allocation_name -l nodes=1:ppn=1:gpus=1 -l pmem=10gb -l walltime=1:00:00`
2.  Set up the environment  
    `$ export PATH=/usr/local/cuda-9.1/bin:$PATH  
    $ export LD_LIBRARY_PATH=/usr/local/cuda-9.1/lib64:$LD_LIBRARY_PATH  
    $ export CPATH=/usr/local/cuda-9.1/samples/common/inc:$CPATH`
3.  Copy the nbody source code to your ACI work directory  
    `$ mkdir ~/work/cuda_example && cd ~/work/cuda_example  
    $ cp /usr/local/cuda-9.1/samples/5_Simulations/nbody/ .`
4.  Compile the nbody example  
    `$ cd nbody  
    $ make`
5.  Compare GPU vs CPU timing  
    ``CPU:  
    $ ./nbody -benchmark -numbodies=1024 -cpu``GPU:  
    $ ./nbody -benchmark -numbodies=1024 -numdevices=1

**CUDA resources**

*   XSEDE course: [slides](https://drive.google.com/file/d/12TwgVcVqoW8T9eyz7RuYQ9yw_si8kbA4/view "XSEDE course presentation") and [video](https://www.youtube.com/watch?v=2R5R0nXm3xc&feature=youtu.be "XSEDE course video")
*   [NVIDIA Education & Training](https://developer.nvidia.com/cuda-education-training "NVIDIA Education & Training")
*   [Virtual Workshop](https://cvw.cac.cornell.edu/GPU/default "Cornell University Virtual Workshop")

##### <span class="titlemark">7.5.4</span> OpenACC

OpenACC is an API comprised of compiler directives (similar to OpenMP) that enable programmers to specify portions of code (C, C++, and Fortran) to be executed on a GPU (or other accelerators). OpenACC compiler support will be available on the Roar systems with the release v18.5 of the PGI compilers. This section will be expanded once the PGI compilers are released.

##### <span class="titlemark">7.5.5</span> GPU Enabled Applications

Some software packages available on the Roar software stack have native GPU support, as indicated in the table below. For a full description of available functionality, please consult each package’s software documentation.

|Software|Information|
|--- |--- |
|Matlab|[MathWorks: Getting started with GPUs](https://mathworks.com/discovery/matlab-gpu.html)|
|Mathematica|[Wolfram: GPU computing](https://reference.wolfram.com/language/guide/GPUComputing.html)|
|Ansys: APDL|ansys192 -acc nvidia -na N ...|
|Ansys: Fluent|fluent -gpgpu=N ...|
|Ansys: polyflow|polyflow -acc nvidia -na N ...|
|Ansys: other|The -batchoptions command flag can be used to enable GPU support. See the software specific manual available through the GUI for the options available for each Ansys product.  

ex. ansysedt -batchoptions "HFSS/EnableGPU=1" ...|
|Abaqus|abaqus gpus=N ... OR abaqus -gpus N ...|


where N = the number of GPU devices

**Python TensorFlow example**  
TensorFlow is a popular open-source machine learning and deep learning library originally developed by Google. The API is typically used with Python, for which there is GPU support. The following example will walk through the local installation and testing of the GPU-enabled version of TensorFlow.

1.  Start an interactive session on a GPU node  
    `$ qsub -I -A gpu_allocation_name -l nodes=1:ppn=1:gpus=1 -l pmem=10gb -l walltime=1:00:00`
2.  Create a conda environment for tensorflow-gpu  
    `$ cd ~/work  
    $ mkdir conda_gpu_tensorflow && cd conda_gpu_tensorflow  
    $ mkdir $PWD/conda_pkgs  
    $ export CONDA_PKGS_DIRS=$PWD/conda_pkgs  
    $ module load python/3.6.3-anaconda3  
    $ conda create -y --prefix $PWD  
    $ source activate $PWD`  
    (Use `source deactivate` to exit the conda environment.)
3.  Install the cudatoolkit for python. The version of cudatoolkit must be compatible with the GPU driver version. The current driver (390.30) supports up to CUDA 9.1.  
    `$ conda install -y cudatoolkit=9.0`
4.  Install tensorflow-gpu. Note that the packaged binaries were not compiled with optimized instruction sets such as AVX, AVX2, etc. To compile your own version of tensorflow from source, see the official [TensorFlow documentation](https://www.tensorflow.org/install/source "TensorFlow documentation").  
    `$ conda install --no-update-dependencies -y tensorflow-gpu`
5.  Run the GPU test model. The average performance should be ~5,300 examples/sec for a single GPU.  
    `$ git clone https://github.com/tensorflow/models.git`  
    `$ python models/tutorials/image/cifar10/cifar10_train.py`

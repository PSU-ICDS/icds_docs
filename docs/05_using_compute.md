#### 5.1 System Usage

The Roar system uses the Red Hat 7.9 Linux operating system with the module system set up for software. All users will have to use the terminal to access programs, including Open OnDemand users of ACI-i.

##### <span class="titlemark">5.1.1</span> Shells

Unix/Linux shells are command line interpreters that allow for a user to interact with their operating system through utility commands and programs. The Default Unix/Linux shell is BASH (the Bourne-Again SHell) which has extensive online documentation, and common or necessary commands are shown in the table below.

|Command|Description (For full documentation, use the command 'man command' to bring up the manual or find online documentation)|
|--- |--- |
|ls|The 'list' (ls) command is used to display all the files in your current directory. Using the '-a' flag will also show any hidden files (typically files beginning with a '.' like .bashrc)|
|cd|This is the 'change directory' command. Use this to traverse directories (like 'cd work'). To move back a directory level, use 'cd..'.|
|mv|The 'move' command takes two arguments, the first being the file to move and the second being the directory said file should be moved to ('mv file.txt /work/newdirectory/'). Note: 'mv' can also be used to rename a file if the second argument is simply a new file name instead of a directory.|
|mkdir|This command is used to make directories.|
|rmdir|This command is used to delete directories ('rm -rf directory' would also work).|
|touch|This command is used to create files in a similar way to mkdir. ('touch test.txt' will create an empty text file named test).|
|rm|This is the 'remove' command. As mentioned above, it can be used recursively to delete entire directory trees, or it can be used with no flags and a file as the argument to delete a single file.|
|locate|This command is used to locate files on a system. The flag '-i' will make the query case-  
insensitive, and asterisks ('*') will indicate wildcard characters.|
|clear|Clears the terminal of all previous outputs leaving you with a clean prompt.|
|history|Shows the previous commands entered.|
|find|Used for finding files, typically with the -name flag and the name of the file.|
|grep|Used for searching within files.|
|awk|A programming language typically used for data extraction.|
|id|Show all of the groups a user is in.|
|du|Show the disk usage. Typically used with -h (for human readable) and -max-depth=1 to limit to only the directories in that level rather than all files.|
|env|Print out all of the current environment variables.|
|less|View a file.|
|cp|Copy a file. Note the -r (recursive) flag can be used to copy directories.|
|alias|Create an alias (something short) that is interpreted as something else (a complicated command).|
|pwd|Print the current working directory.|
|chmod|Change file permissions.|
|chgrp|Change group for a file or directory.|
|ldd|Show the shared libraries required for an executable or library.|
|top|See the node usage. Often used with command U .|
|/usr/bin/time|Show time and memory statistics for a command being run. Often used with the -v (verbose) flag.|
|bg|Continue running a paused task in the background|
|fg|Bring a background task into the foreground|
|Ctrl + c|Kill a process.|
|Ctrl + z|Suspend a process|
|Ctrl + r|Search through your history for a command that includes the text typed next.|
|* * *|* * *|



There are also some special characters to be aware of that will be helpful.

*   `~` is your home directory
*   `.` means here
*   `..` means up one directory
*   `*` is the wildcard: `*` for all files or `*.png` for all png files
*   `|`is pipe (send the output to another command)
*   `>` means write command output to a file (Example: `ls > log.ls`)

Most commands have a manual that show all of the different ways the command can be used. For example,

`man ls`

shows all of the info for the `ls` command. You can use the arrows to scroll through the manual and the letter `q` for quit. Some commands will also provide a shortened version of the manual showing the available flags if an incorrect flag is used. For example,

`mam-list-funds -banana`

brings up a list of all of the flags available for `mam-list-funds`. Any non-working flag will allow for this. Note that this doesn’t give information about what the flags do, just what the flags are. This may be enough to remind you of something you had done previously.  

All shells utilize configuration files. For BASH, this is split between 2 files: `~/.bash_profile` and `~/.bashrc`.  
(NOTE: `~/` in Linux is a way to specify your own home directory!). The `.bash_profile` file is always parsed when a terminal is open, including with an SSH session. To connect the two in such a way that `.bashrc` will always be sourced for a session, make sure this code is included in your `~/.bash_profile`:

`if [ -f ~/.bashrc ]; then . ~/.bashrc fi`

##### <span class="titlemark">5.1.2</span> Alternative Shells

BASH is only the default shell, and it doesn’t come with quite a few features that many Linux power-users would like to have on the command-line. Other common shells include KSH (KornSHell), ZSH (Z SHell), and FISH (Friendly-Interface SHell). These shells all have documentation available online regarding their installation and customization.  

##### <span class="titlemark">5.1.3</span> Environmental Variables

Environment variables are values that pertain to certain aspects of an operating system’s configurations. These variables are typically used by utilities and programs for things like finding out where the user’s home directory is (`$HOME`) or where to look for executable files (`$PATH`). The prompt for BASH is held as the variable `PS1`.  

You can print the environment variable to the screen using the `echo` command:

`echo $HOME`

A good way to view environment variables that are set is by using the `env` command

`env`

which outputs all of the variables currently in use.  

To change the value of an existing variable or to create and set a new variable, we use `export`. For example, to set a variable called `workDir` to a directory called here within your home directory, the command would be:

`export workDir=$HOME/here`

Once this environment variable is set, you are able to use this. For example, to change to this directory, the command would be:

`cd $workDir`

For something like PATH where you really do not want to overwrite what values are already stored, you can append values with

`export PATH=$PATH:/new/dir/path/`

In lists of values, the colon (`:`) is used as the delimiter. The dollar sign (`$`) is used to reference variables, so that export command essentially appends the new directory to the list of existing directories searched for executables. It is possible to prepend as well, which may come in handy if you compile a different version of an existing command.  

For more general reading on environment variables in Linux, see these pages on [variables](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html) and [environmental variables](https://en.wikipedia.org/wiki/Environment_variable).  

The environment variables allow for script portability between different systems. By referencing variables like the home directory ($HOME) you can generalize a script’s functionality to work across systems and accounts.

|Variable Name|Description|
|--- |--- |
|USER|Your user ID|
|HOSTNAME|The name of the server that the script is being run on|
|HOME|Your home directory|
|WORK|Your work directory|
|SCRATCH|Your scratch directory|
|TMPDIR|The directory in which a job's temporary files are placed (created and deleted automatically)|


##### <span class="titlemark">5.1.4</span> References

The Linux terminal and submitting jobs are not unique to Roar. You can find many different training resources online for these. The Linux foundation offers [free training](https://training.linuxfoundation.org/free-linux-training). Lots of great information and tutorials for everyone from beginner Linux user to advanced users can be found [here](https://www.linux.org/pages/download/). Linux has been around for a long time. Therefore, any problem you might be having, someone has probably already had. It is always worthwhile to look around [stack exchange](https://unix.stackexchange.com/) to see if your question has already been answered.


### Running Jobs on ACI-b

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

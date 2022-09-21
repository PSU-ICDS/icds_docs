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

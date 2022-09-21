---
title: Software Stack
---

ICDS has a software policy that explains the details of how software can be used. The policy can be read on [our policy page](https://www.icds.psu.edu/computing-services/ics-aci-policies/).  


#### 9.1 User Stack

Users are able to install software into their own home and work directories as well as in group spaces. ICDS strongly recommends that research groups who compute in multiple locations do this for all of their software so that the version can be consistent across platforms.  

The i-ASK Center can provide guidance for the installation of many software packages.  
  


#### 6.1 Version Control

Version control is a way to track multiple versions of a code. This has a place in development, primarily with adding new features while still using the original code or with multiple developers, and if the code has minor variants for reasons such as slightly different input/output data types or for use on different compute resources. One popular version control tool is `git`, which uses a distributed approach which allows for many development points. The basic `git` workflow is to

*   Modify files - create new code, fix bugs, etc.
*   Stage the files - explicitly state what will be deposited
*   Commit your files - store a snapshot

Your repository will have a master branch, where the current production code usually exists, and other branches that may be for any other purpose, such as development or variations. Branches can either be merged back to the master branch as features are added and execution is validated, or kept separate if the usage requires multiple working versions of the code. It is up to the user to define how their repository is set-up as well as to keep non-local versions of the repository as up-to-date as desired. There are great online resources for `git` including [excellent documentation](http://git-scm.com/doc) and [tutorials](http://try.github.io).

  

#### 6.2 Basic Compilation

You can your own compile code for running on Roar. A basic compilation might look like

`gcc -O2 -lm -o hello.out hello.c <\pre>`

where the gnu compiler is used to compile a C code in the file hello.c.

*   `gcc` Compiler being used
*   `-O2` Optimization Flag
*   `-lm` Link to the math library
*   `-o hello.out` Output file
*   `hello.c` Input file

It’s possible to link to pre-compiled libraries that are created by you or that already exist on the system. The `module show` command can be very useful in determining the locations of the libraries and header files required to compile codes. You can link in a variety of ways.

*   `-L` (as in Love) Path to a directory containing a library
*   `-l` (as in love) Library name
*   `-I` (as in Iowa) Path to header files

Complicated compilations can also be done using a build automation software package such as `make`, which is available without a module, or `cmake`, which is available as a module. The general build automation process involves using a Makefile that has:

*   Outputs - the executable/library being created
*   Dependencies - what each output relies on
*   Instructions - how to make/find each dependency

and can set environment variables. The nomenclature for repeated sections can use regex and so can be very complicated. Information about these tools can be found in online references, such as the [make](http://gnu.org/software/make/manual/make.html) and [cmake](https://cmake.org/documentation/) manuals. Some common pitfalls that the iAsk center sees for using make are:

*   Makefiles require tabs and not spaces at the beginning of indented lines
*   The `-j` flag and an integer can be used to compile on multiple processors
*   The `-f` flag can be used to specify the name of the makefile if not Makefile
*   Some makefiles are configured for the compute environment. You may need to use the command `./configure` if there isn’t a make file and configure scripts exist./li>

It is possible to either make the output file directly executable and add the location to your path to call this from anywhere, or to execute the output from the location of the file directly. For our hello example from before, this can be done using the command `./hello.out` from the directory in which the executable exists.

  

#### 6.3 Libraries

Roar offers many optimized libraries for users to link to. Please see the most common libraries listed below.  

##### 6.3.1 MKL

Intel Math Kernel Library (MKL) consists of commonly used mathematical operations in computational science. The functions in MKL are optimized for use on Intel processors. More information can be found [here.](https://software.intel.com/en-us/mkl)  

The MKL module can be loaded using the command

`module load mkl`

##### 6.3.2 LAPACK

LAPACK (Linear Algebra Package) is a software library used for numerical linear algebra. It can handle many common numerical algebra computations such as solving linear systems, eigenvalue problems, and matrix factorization. It depends on BLAS. More information can be found on the [website.](http://www.netlib.org/lapack/)  

You can load the LAPACK module using the commands:

`module load gcc/5.3.1
module load lapack/3.6.0
`

##### 6.3.3 BLAS

BLAS (Basic Linear Algebra Subprograms) is a collection of low level matrix and vector operations such as vector addition, scalar multiplication, matrix multiplication, etc. For more information, refer to this [link.](http://www.netlib.org/blas/)  

The BLAS module can be loaded with the command

`module load blas`

##### 6.3.5 Boost

Boost is a C++ library that contains many useful functions covering a wide range of applications such as linear algebra and multithreading. More information can be found [here.](http://www.boost.org/)

You can load Boost with the command

`module load boost`

##### 6.3.6 PETsc

The Portable, Extensible Toolkit for Scientific Computation (PETsc, pronounced PET-see) is a suite of data structures and routines for solving partial differential equations and sparse matrices in a parallel fashion that is scalable. It was developed by Argonne National Laboratory.  

You can load the PETsc module using the command

`module load petsc/3.8.3`

More information on features, tutorials, manuals, etc can be found on the [website.](http://www.mcs.anl.gov/petsc/)





#### 9.2 System Stack

Many commonly used applications are built and maintained by the system.  

##### 9.2.1 System Stack Requests

Requests for software to be placed on the system stack can be made to the i-ASK Center. Users requesting software should show the reason for the request, typically due to licensing issues or because of the broad user base across campus.  
 
 
 

#### 5.2 Module System

Roar now uses the Lmod environment modules system. Environment Modules provide a convenient way to dynamically change the users environment through modulefiles. This includes easily adding or removing directories to the `PATH`, `LD_LIBRARY_PATH`, `MANPATH`, and `INFOPATH` environment variables. A modulefile contains the necessary information to allow a user to run a particular application or provide access to a particular library. All of this can be done dynamically without logging out and back in. Modulefiles for applications modify the users path to make access easy. Modulefiles for library packages provide environment variables that specify where the library and header files can be found. Learn more about modules on [TACC’s website](https://www.tacc.utexas.edu/research-development/tacc-projects/lmod).

##### 5.2.1 Module Families

Roar uses module families for compilers and parallelization libraries. Modules that are built with a parent module, such as a compiler, are only available when the parent module is loaded. For example, the version of LAPACK built with the gcc module is only available when the gcc module is located.

A good way to illustrate how the module families work is to view the available modules before a family is loaded as well as after. You can do this with the gcc family by inspecting the output of

<pre class="script">module purge

module avail

module load gcc/8.3.1

module avail

`

##### 5.2.2 Using Modules

You can load modules into your environment with the command with the module load command. For example, to load the gcc module, you can use the command:

`module load gcc/8.3.1`

Note that the version number is not required. Each software will have a default module that will be loaded if no version number is provided. However, it is recommended that you put the version number so that you know and have a record of what version is being used.  

You can view the modules that you currently have open using the module list command:

`module list`

You can also unload modules that you do not need in the same way:

`module unload gcc/8.3.1`

It is also possible to remove all of your loaded modules at once using purge:

`module purge`

##### 5.2.3 Querying Modules

You can view the available modules using the command:

`module avail`

Note that this only looks at the available modules, which may be limited by module family based on modules are currently loaded. You can search all of the modules using `module spider`. For example, to search for VASP, you can use the command

`module spider vasp`

which will search through all module names and module files to return anything related to vasp.  

The module can be used to give you information about the software using the module show command. For  
example, the information about the hdf5 module, which was built using the gcc module, can be seen using the commands:

<pre class="script">module load gcc/8.3.1

module show hdf5/1.10.7

`

The output of this is shown:

<pre class="script">---------------------------------------------------------------------

/opt/aci/modulefiles/Compiler/gcc/8.3.1/hdf5/1.10.7.lua:

---------------------------------------------------------------------

help([[HDF5 is a unique technology suite that makes possible the management of extremely large and complex data collections. The HDF5 technology suite includes: A versatile data model that can represent very complex objects and a variety of metadata. A completely portable file format with no limit on the number or size of data objects in the collection. A software library that runs on a range of computational platforms, from laptops to massively parallel systems, and implements a high-level API with C, C++, Fortran 90, and Java interfaces. A rich set of integrated performance features that allow for access time and storage space optimizations. Tools and applications for managing, manipulating, viewing, and analyzing the data in the collection.
]])

whatis("Description: HDF5 is a unique technology suite that makes possible the management of extremely large and complex data collections.")

whatis("URL: https://support.hdfgroup.org/HDF5/")

prepend_path("PATH","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1/bin")

prepend_path("LD_LIBRARY_PATH","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1/lib64")

prepend_path("C_INCLUDE_PATH","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1/include")

prepend_path("CPLUS_INCLUDE_PATH","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1/include")

prepend_path("LIBRARY_PATH","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1/lib64")

pushenv("HDF5","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1")

pushenv("HDF","/opt/aci/sw/hdf5/1.8.18_gcc-8.3.1")

`

Note that this tells you some information about the software, gives a website for more help and shows the environment variables that are modified. The environment manipulation section can be very helpful for users who are compiling codes and linking to libraries as these paths indicate where the relevant objects may be found.  

##### 5.2.4 Controlling Modules Loaded at Login

Most shells have a configuration file that allows you to set aliases (nicknames for commands both simple or complex), set environment variables, and automatically execute programs and commands. In this case we are interested in the last mentioned feature: automating commands at login. For BASH there are two files at play: `~/.bash_profile` and `~/.bashrc.` To force your bashrc to be sourced in every opened terminal and SSH session, include this code in your bash_profile:

`if [ -f ~/.bashrc ]; then

. ~/.bashrc

fi
`

Once that has been done, you can add whatever automated module loads you want in the .bashrc file by including:

`module load <module name>/<version>`

The version specification is optional, excluding it will cause whatever the default version is to be loaded. Other shells have similar configuration methods that are detailed in online documentation.

#### 9.3 System Stack Applications

Because of the module families, it is hard to view all of the available software on the system. The software list can be found on the [software stack webpage](https://www.icds.psu.edu/computing-services/software/) or by looking in the directory where the software modules are:

`ls /opt/aci/sw/`

##### 9.3.1 COMSOL

To open COMSOL, first log into ACI-i using Open OnDemand. More information regarding how to do this can be found in [section 5.4.1](https://www.icds.psu.edu/computing-services/ics-aci-user-guide/#05-04-connecting-aci). Next open a terminal by going to the top left corner and clicking on

`Applications -> System Tools -> Terminal`

In the terminal window type the following commands:

`module load comsol
comsol
`

The graphical user interface for COMSOL should now be opened and COMSOL can be used as usual. However, it is worth mentioning that ACI-i is only intended to run short jobs. Often researchers will use ACI-i to develop and test their COMSOL models before submitting them as jobs on the more computational powerful ACI-b cluster. Running a COMSOL model on the ACI-b system is a relatively straightforward process. To do so, first create your model (often done using the GUI in ACI-i). Next log into ACI-b, and submit your job to the scheduler. For information on submitting a job to ACI-b, see [section 7](https://www.icds.psu.edu/computing-services/ics-aci-user-guide/#07-00-running-jobs-on-aci-b).  

An example of a PBS script to submit a COMSOL job:

<pre class="script">
	#!/bin/bash
	#PBS -l nodes=1:ppn=4
	#PBS -l walltime=12:00:00
	#PBS -A open
	#PBS -o ComsolPBS.output
	#PBS -e ComsolPBS.error
	#PBS -m abe
	#PBS -M abc1234@psu.edu
	#PBS -n myComsolJob

	# Get started
	echo " "
	echo "Job started on ‘hostname‘ at ‘date‘"
	echo " "

	# Load in Comsol
	module purge
	module load comsol

	# Go to the correct place
	cd $PBS_O_WORKDIR

	# Run the job itself
	comsol batch -inputfile inputFile.mph -outputfile /path/to/output/outputFileName.mph -batchlog log.txt

	# Finish up
	echo " "
	echo "Job Ended at ‘date‘"
	echo " "
`

More information on options used for submitting comsol jobs using the command line can be found by typing the commands:

`
	module load comsol
	comsol -h
`

##### 9.3.2 Julia

Julia is a high-level, high-performance dynamic programming language for numerical computing. It provides a sophisticated compiler, distributed parallel execution, numerical accuracy, and an extensive mathematical function library. Julia’s Base library, largely written in Julia itself, also integrates mature, best-of-breed open source C and Fortran libraries for linear algebra, random number generation, signal processing, and string processing.  

The system Julia module is compiled with the GCC compiler. Using Julia requires the gcc module to be loaded:

`$ module load gcc
$ module load julia
$ julia
`

Example Julia Code:

<pre class="script">Pkg.add("Winston")

using Winston

# optionally call figure prior to plotting to set the size

figure(width=600, height=400)

# plot some data

pl = plot(cumsum(rand(500) .- 0.5), "r", cumsum(rand(500) .- 0.5), "b")

# display the plot (not done automatically!)

display(pl)

# by default display will not wait and the plot will vanish as soon as it appears

# using readline is a blunt wait to allow the user to choose when to continue

# println("Press enter to continue: ")

# readline(STDIN)

# save the current figure

savefig("winston.svg")

# .eps, .pdf, & .png are also supported
# we used svg here because it respects the width and height specified above

`

An example PBS submission script for a julia simulation can be found:

	#!/bin/bash
	#PBS -l procs=1
	#PBS -l walltime=240:00:00
	#PBS -l pmem=1000mb
	#PBS -n jobName
	#PBS -m ea
	#PBS -M PSU1234@psu.edu
	#PBS -j oe

	module load gcc
	module load julia

	cd $PBS_O_WORKDIR

	julia jobName.ji

##### 9.3.3 Matlab

Matlab is a widely used programming environment and language. The GUI can be accessed on ACI-i using the following commands:

`module load matlab
matlab
`

Matlab can also be run in batch mode, either on the command line or submitted as a job. Jobs run in batch mode must have an *.m file. An example that writes a random matrix as a .csv file:

<pre class="script">%This Matlab script makes a random matrix and outputs a csv file of it.

%This was made as a simple example to demostrate how to submit batch Matlab

%codes

%Created by i-ASK at ICDS of Penn State

% June 27, 2017

%% Create Random Matrix

RandomMatrix = rand(5);

%% Export csv file

csvwrite(’output.csv’,RandomMatrix)

`

This can be saved as Example.m and submitted to ACI-b using the following submission script:

<pre class="script">#!/bin/bash

#PBS -S /bin/bash

#PBS -l nodes=1:ppn=1,walltime=00:05:00

#PBS -N MyJobName

#PBS -e error.txt

#PBS -o output.txt

#PBS -j oe

#PBS -A open

#PBS -m abe

#PBS -M abc1234@psu.edu

# Get started

echo " "

echo "Job started on ‘hostname‘ at ‘date‘"

echo " "

# Load in matlab

module purge

module load matlab

# Run the job itself

matlab -nodisplay -nosplash -r Example > logfile.matlabExample

# Finish up

echo " "

echo "Job Ended at ‘date‘"

echo " "

`

For more information about Matlab, please refer to the [Matlab website](https://www.mathworks.com/products/matlab.html).  

##### 9.3.4 Mathematica

Mathematica builds in unprecedentedly powerful algorithms across all areas many of them created at Wolfram using unique development methodologies and the unique capabilities of the Wolfram Alpha. Mathematica is built to provide industrial-strength capabilities with robust, efficient algorithms across all areas, capable of handling large-scale problems, with parallelism, GPU computing, and more . Mathematica provides a progressively higher-level environment in which as much as possible is automated so you can work as efficiently as possible.  

The Mathematica module can be loaded with the command

`module load mathematica`

A sample Mathematica code for printing random numbers into a text file:

<pre class="script">Accumulate[RandomReal[{-1, 1}, 1000]]>>"output.txt"

Quit [ ]

`

More examples of Mathematica code can be found [here.](https://www.wolfram.com/language/gallery/)

Sample Shell script for Batch System

<pre class="script">#!/bin/bash

#PBS -N jobname

#PBS -l nodes=1:ppn= 1

#PBS -l mem=2gb,walltime=00:10:00

#PBS -A open

#PBS -o samplePBS.output

#PBS -e samplePBS.error

# Get started

echo " "

echo "Job started on ‘hostname‘ at ‘date‘"

echo " "

# Load in Mathematica

module purge

module load mathematica

# Go to the correct place

cd $PBS_O_WORKDIR

# Run the job itself

math -noprompt -run ’<<samplecode.nb’

# Finish up

echo " "

echo "Job Ended at ‘date‘"

echo " "

`

An additional PBS submission script sample for Mathematica is given here:

<pre class="script">#!/bin/bash

#PBS -l nodes=1:ppn=1

#PBS -l walltime=5:00

#PBS -A open

#PBS -o MathematicaPBS.output

#PBS -e MathematicaPBS.error

# Get started

echo " "

echo "Job started on ‘hostname‘ at ‘date‘"

echo " "

# Load in Mathematica

module purge

module load mathematica

# Go to the correct place

cd $PBS_O_WORKDIR

# Run the job itself

math -noprompt -run ’<<input.m’

# Finish up

echo " "

echo "Job Ended at ‘date‘"

echo "

`

##### 9.3.5 Stata

Stata is a powerful statistical package with smart data-management facilities, a wide array of up-to-date statistical techniques, and an excellent system for producing publication-quality graphs. It is widely used by many businesses and academic institutions especially in the fields of economics, sociology, political science, biomedicine and epidemiology. Stata is available for Windows, Linux/Unix, and Mac computers. There are four versions of Stata as follows:

*   Stata/MP for multiprocessor computers (including dual-core and multicore processors). Stata/MP is licensed based on the maximum number of cores than an individual job can use. RCC licenses Stata/MP16, which can run on up to 16 cores.
*   Stata/SE for large databases
*   Stata/IC which is the standard version
*   Small Stata which is a smaller, student version of educational purchase only.

For parallel processing in Stata you must use stata-mp at the bottom of your PBS script. You must also indicate the number of processors (up to 16) in the PBS script as well as your do file. As a line in your do file be sure to include "set processors n", where n = the number of processors and should be the same as the number in your PBS script. An example PBS script is below where the number of processors is set to 8.  

Setup:  

In Linux, load the module with the following command before you start working with Stata:

`module load stata`

Note that this command will load the current version. Other available versions can be checked by following command:

`module avail stata`

Usage To start Stata , type:

`stata-mp`

Use only ACI-i for interactive jobs. If you are remotely connecting to our systems via Open OnDemand, we recommend using the GUI version of Stata:

`xstata-mp`

Batch usage: Sample PBS script is given below:

<pre class="script">#!/bin/bash

#PBS -l nodes=1:ppn=1

#PBS -l walltime=00:15:00

#PBS -A open

#PBS -n jobName

#PBS -M user123@psu.edu

#PBS -m abe

#PBS -j oe

# Get started

echo " "

echo "Job started on ‘hostname‘ at ‘date‘"

echo " "

# Load in Stata

module purge

module load stata

# Go to the correct place

cd $PBS_O_WORKDIR

# Run the job itself

stata -b do filename

# Finish up

echo " "

echo "Job Ended at ‘date‘"

echo " "

`

You can use stata-mp by substituting the stata command with the following:

`stata-mp -b do jobName.do`

##### 9.3.6 Python

Python is a multi-use programming language used in a wide variety of fields. It can be run in batch mode on ACI-i or used in submitted jobs on ACI-b.  

An example python script, named jobName.py:

<pre class="script">import sys

jobName = [Hello, World]

for i in jobName:

print i

sys.exit(0)

#end of jobName.py

`

This script can be submitted as a job on ACI-b with the following script:

<pre class="script">#!/bin/bash -l

#PBS N jobName

#PBS l nodes=1:ppn=12

#PBS l walltime=00:05:00

#PBS j oe

#PBS -M abc123@psu.edu

# Get started

echo " "

echo "Job started on ‘hostname‘ at ‘date‘"

echo " "

#load in python

module purge

module load python/2.7.1

#go to the correct work directory

cd $PBS_O_WORKDIR

python jobName.py

# Finish up

echo " "

echo "Job Ended at ‘date‘"

echo " "

`

For more information, please feel free to refer to the [Python website](https://www.python.org/).  

An excellent resource for various plotting methods found within python can be found at the [matplotlib gallery.](https://matplotlib.org/gallery.html)

##### 9.3.7 Singularity

Singularity is a _container_ system developed for use on high-performance computing clusters. Container computing allows the creation of a virtual-machine-like environment, which gives the user access to different configurations of software for use on clusters.

Using Singularity to install a container on Roar can help users:

*   avoid dependence challenges
*   perform the same expected behavior on local and remote systems
*   easily move containers to new locations

This may help if you need to run a container without having sudo access, but keep in mind that the container must integrate seamlessly into the existing destination infrastructure.

_8.3.7.1 Getting Started with Using Singularity_

Before getting started with using Singularity on Roar, you will need to install Singularity on a system for which you have root access. [Singularity’s official user guide](https://www.sylabs.io/docs/) provides instructions for doing this. Roar uses version 2.6.0 of Singularity.

You may also obtain help in ACI-b like so:

<pre class="script">[cjb47@comp-sc-0157 ~]$ singularity help
USAGE: singularity [global options...] <command></command> [command options...] ...
GLOBAL OPTIONS:
-d|--debug Print debugging information
-h|--help Display usage summary
-s|--silent Only print errors
-q|--quiet Suppress all normal output
--version Show application version
-v|--verbose Increase verbosity +1
-x|--sh-debug Print shell wrapper debugging information
GENERAL COMMANDS:
help Show additional help for a command or container
selftest Run some self tests for singularity install
CONTAINER USAGE COMMANDS:
exec Execute a command within container
run Launch a runscript within container
shell Run a Bourne shell within container
test Launch a testscript within container
CONTAINER MANAGEMENT COMMANDS:
apps List available apps within a container
bootstrap *Deprecated* use build instead
build Build a new Singularity container
check Perform container lint checks
inspect Display container's metadata
mount Mount a Singularity container image
pull Pull a Singularity/Docker container to $PWD
COMMAND GROUPS:
image Container image command group
instance Persistent instance command group
CONTAINER USAGE OPTIONS:
see singularity help <command></command>
For any additional help or support visit the Singularity
website: https://www.sylabs.io`

_9.3.7.2 Images supported_

Singularity supports many types of containers, which are also known as images. These include:

|Image Type|Description|
|--- |--- |
|simg|standard image|
|directory|Unix Directory containing root container image|
|tar.gz|Gzip compressed tar archive|
|tar.bx2|Bzip2 compressed tar archive|
|tar|uncompressed tar archive|
|cpio.gz|Gzip compressed CPIO archive|
|cpio|Uncompressed CPIO archive|


Standard image and directory are the most commonly used formats. The others tend to be archive of the directory format that are decompressed on the fly.

_Note: Docker Integration_  
Singularity supports Docker natively and directly. This means that nearly all Docker images can be used directly as long as the required functionality does not require root access; however, most applications do not require this. We provide an example in the next section, Obtaining pre-built images.

_9.3.7.3 Obtaining Pre-built Images_

Images built by others users, sometimes the developers of the desired software itself, are among the best choices for a base image and, in many cases, may be all a researcher needs to do to have an image that gives the desired outcome.

Here is a common-example, the Docker image, lolcow.

<pre class="script">[cjb47@comp-sc-0161 ~]$ singularity run docker://godlovedc/lolcow
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
Docker image path: index.docker.io/godlovedc/lolcow:latest
Cache folder set to /storage/home/c/cjb47/.singularity/docker
[1/1] |===================================| 100.0%
Creating container runtime...
Exploding layer:
˓→sha256:9fb6c798fa41e509b58bccc5c29654c3ff4648b608f5daa67c1aab6a7d02c118.tar.gz
Exploding layer:
˓→sha256:3b61febd4aefe982e0cb9c696d415137384d1a01052b50a85aae46439e15e49a.tar.gz
Exploding layer:
˓→sha256:9d99b9777eb02b8943c0e72d7a7baec5c782f8fd976825c9d3fb48b3101aacc2.tar.gz
Exploding layer:
˓→sha256:d010c8cf75d7eb5d2504d5ffa0d19696e8d745a457dd8d28ec6dd41d3763617e.tar.gz
Exploding layer:
˓→sha256:7fac07fb303e0589b9c23e6f49d5dc1ff9d6f3c8c88cabe768b430bdb47f03a9.tar.gz
Exploding layer:
˓→sha256:8e860504ff1ee5dc7953672d128ce1e4aa4d8e3716eb39fe710b849c64b20945.tar.gz
Exploding layer:
˓→sha256:736a219344fbca3099ce5bd1d2dbfea74b22b830bac0e85ecca812c2983390cd.tar.gz
WARNING: Non existent bind point (directory) in container: '/storage/home'
WARNING: Non existent bind point (directory) in container: '/storage/work'
WARNING: Non existent bind point (directory) in container: '/gpfs/scratch'
WARNING: Non existent bind point (directory) in container: '/gpfs/group'
WARNING: Non existent bind point (directory) in container: '/var/spool/torque'
WARNING: Could not chdir to home: /storage/home/cjb47
________________________________________
/ Tonight you will pay the wages of sin; \
\ Don't forget to leave a tip. /
----------------------------------------
\   ^__^
\   (oo)\_______
    (__)\       )\/\
        ||----w |
        ||     ||
`

This example presents problems in certain cases, because the image does not have access to the data on the Roar system:

<pre class="script">[cjb47@comp-sc-0185 singularity]$ singularity shell docker://godlovedc/lolcow
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
Docker image path: index.docker.io/godlovedc/lolcow:latest
Cache folder set to /storage/home/c/cjb47/.singularity/docker
Creating container runtime...
Exploding layer:
˓→sha256:9fb6c798fa41e509b58bccc5c29654c3ff4648b608f5daa67c1aab6a7d02c118.tar.gz
Exploding layer:
˓→sha256:3b61febd4aefe982e0cb9c696d415137384d1a01052b50a85aae46439e15e49a.tar.gz
Exploding layer:
˓→sha256:9d99b9777eb02b8943c0e72d7a7baec5c782f8fd976825c9d3fb48b3101aacc2.tar.gz
Exploding layer:
˓→sha256:d010c8cf75d7eb5d2504d5ffa0d19696e8d745a457dd8d28ec6dd41d3763617e.tar.gz
Exploding layer:
˓→sha256:7fac07fb303e0589b9c23e6f49d5dc1ff9d6f3c8c88cabe768b430bdb47f03a9.tar.gz
Exploding layer:
˓→sha256:8e860504ff1ee5dc7953672d128ce1e4aa4d8e3716eb39fe710b849c64b20945.tar.gz
Exploding layer:
˓→sha256:736a219344fbca3099ce5bd1d2dbfea74b22b830bac0e85ecca812c2983390cd.tar.gz
WARNING: Non existent bind point (directory) in container: '/storage/home'
WARNING: Non existent bind point (directory) in container: '/storage/work'
WARNING: Non existent bind point (directory) in container: '/gpfs/scratch'
WARNING: Non existent bind point (directory) in container: '/gpfs/group'
WARNING: Non existent bind point (directory) in container: '/var/spool/torque'
WARNING: Could not chdir to home: /storage/home/cjb47
Singularity: Invoking an interactive shell within container...
Singularity lolcow:/> cd ~
bash: cd: /storage/home/cjb47: No such file or directory
`

We can note the first issue, the non-existent bind paths. For this type of image, add the bind paths by slightly modifying the images. This can be done by writing a simple set of instructions, which are used to create an image. This set of instructions is called a recipe, in Singularity terminology.

_9.3.7.4 Handling the Bind Paths on Roar_

In order to handle the bind paths, it is very helpful to start with a recipe to set the data paths, even if the image is mostly a prepared image from another source. We will take a look at how to do this, and then discuss the building process in more detail.

We can also start with a recipe and add the correct binding paths for ACI-b. Here is a simple example to handle the bind points using the lolcow image.

<pre class="script">BOOTSTRAP: docker
FROM: godlovedc/lolcow
%post
#ACI mappings so you can access your files.
mkdir -p /storage/home
mkdir -p /storage/work
mkdir -p /gpfs/group
mkdir -p /gpfs/scratch
mkdir -p /var/spool/torque
`

We build the image in an environment where we have sudo access (not Roar):

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
`

Next, transfer the image to Roar using scp, and run it:

<pre class="script">[cjb47@comp-sc-0185 images]$ singularity run ./lolcow.simg
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
_________________________________________
/ The Priest's grey nimbus in a niche \
| where he dressed discreetly. I will not |
| sleep here tonight. Home also I cannot |
| go. |
| |
| A voice, sweetened and sustained, |
| called to him from the sea. Turning the |
| curve he waved his hand. A sleek brown |
| head, a seal's, far out on the water, |
| round. Usurper. |
| |
\ -- James Joyce, "Ulysses" /
-----------------------------------------
\   ^__^
\   (oo)\_______
    (__)\       )\/\
        ||----w |
        ||     ||
`

Note that we are now able to access our data on the local Roar locations.

<pre class="script">[cjb47@comp-sc-0185 images]$ singularity shell ./lolcow.simg
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
Singularity: Invoking an interactive shell within container...
Singularity lolcow.simg:/gpfs/group/dml129/default/cjb47/singularity/images> cd ~
Singularity lolcow.simg:~> pwd
/storage/home/cjb47
`

##### 9.3.7.5 Ways of using Singularity containers

Once a container has been built and is placed on Roar, you can use it in a variety of ways. Here, we explain a few ways, including:

*   ACI-b interactive sessions
*   ACI-n batch sessions
*   Interactive shells
*   Executing commands
*   Running a container
*   Working with files

_ACI-b Interactive Sessions:_

You can start an interactive sessions with X-forwarding using the following command:

(script: qsub -l walltime=04:00:00 -l nodes=1:ppn=4 -A open -I -X)O

**Warning:** Do not run interactive sessions on the log-in (head) nodes. These nodes are shared among all users and can quickly be rendered unusable by computationally intensive jobs on the sessions. Use of the head nodes to perform computationally demanding tasks can lead to the programs being terminated, or deactivation of the user’s access to Roar.

_ACI-b Batch Sessions:_

Here are a few examples that will run an application or command non-interactively in a PBS job file.

<pre class="script">#!/bin/bash
#PBS -N Lammps-singularity
#PBS -A open
#PBS -l walltime=04:00:00
#PBS -l nodes=2:ppn=20
#PBS -j oe
module load gcc/5.3.1 mpich/3.2
cd $PBS_O_WORKDIR
mpirun --hostfile $PBS_NODEFILE --np 40 singularity run /path/to/lammps_mpi.simg   in.
˓→friction \
> out.friction
`

_Interactive Shells:_

If you need to use many interactive tools or applications, you may want to start an interactive shell. Use the following command to do this:

<pre class="script">[cjb47@comp-bc-0226 images]$ cat /etc/issue
Red Hat Enterprise Linux Server release 6.10 (Santiago)
Kernel \r on an \m
[cjb47@comp-bc-0226 images]$ singularity shell ubuntu_aci.simg
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
Singularity: Invoking an interactive shell within container...
Singularity ubuntu_aci.simg:/gpfs/group/dml129/default/cjb47/singularity/images> cat /
˓→etc/issue
Ubuntu 16.04.5 LTS \n \l
`

You will be able to interact with directories that have been bound.

_Executing Commands:_

In some cases, you may only want to run a single command from within the container. The following is an example of this:

<pre class="script">[cjb47@comp-bc-0226 images]$ R
R version 3.5.0 (2018-04-23) -- "Joy in Playing"
Copyright (C) 2018 The R Foundation for Statistical Computing
Platform: x86_64-redhat-linux-gnu (64-bit)
R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.
R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.
Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.
> q()
Save workspace image? [y/n/c]: n
[cjb47@comp-bc-0226 images]$ singularity run shub://jekriske/r-base:3.4.4 R
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
Progress |===================================| 100.0%
WARNING: Non existent mountpoint (directory) in container: '/var/singularity/mnt/
˓→final/storage/home'
WARNING: Non existent mountpoint (directory) in container: '/var/singularity/mnt/
˓→final/storage/work'
WARNING: Non existent mountpoint (directory) in container: '/var/singularity/mnt/
˓→final/gpfs/scratch'
WARNING: Non existent mountpoint (directory) in container: '/var/singularity/mnt/
˓→final/gpfs/group'
WARNING: Non existent mountpoint (directory) in container: '/var/singularity/mnt/
˓→final/var/spool/torque'
WARNING: Could not chdir to home: /storage/home/cjb47
ARGUMENT 'R' __ignored__
R version 3.4.4 (2018-03-15) -- "Someone to Lean On"
Copyright (C) 2018 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)
R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.
Natural language support but running in an English locale
R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.
Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.
> q()
Save workspace image? [y/n/c]: n
`

_Running a Container:_

Some containers may have one or more runscripts, which allow a user to define a set of actions a container will run when it is called. For example:

<pre class="script">[cjb47@comp-bc-0226 images]$ singularity run ./hello-world-aci.simg
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
Hello there cjb47, from ICDS
`

A container may have multiple runscripts; in Singularity terminology, this is known as an "application." Here is an example, including instructions for interacting with applications:

<pre class="script">[cjb47@comp-sc-0120 images]$ singularity apps ./multiapps-aci.simg
cowsay
fortune
lolcat
[cjb47@comp-sc-0120 images]$ singularity run --app fortune ./multiapps-aci.simg -a
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
FORTUNE PROVIDES QUESTIONS FOR THE GREAT ANSWERS: #19
A: To be or not to be.
Q: What is the square root of 4b^2?
[cjb47@comp-sc-0120 images]$ echo "Hello from lolcat" > file
[cjb47@comp-sc-0120 images]$ singularity run --app lolcat ./multiapps-aci.simg file
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
Hello from lolcat
`

_Working with Files:_

As long as there are corresponding binding points, you will be able to reach files on the host from within the container. Since Roar has user storage in non-standard locations (compared to distribution default), you will need to add the appropriate locations to a recipe.

In the following example, we need binding for ACI-b:

<pre class="script">%post
#ACI mappings so you can access your files.
mkdir -p /storage/home
mkdir -p /storage/work
mkdir -p /gpfs/group
mkdir -p /gpfs/scratch
mkdir -p /var/spool/torque
`

##### 9.3.7.6 More information on building Singularity containers

The official [Singularity user guide](https://www.sylabs.io/guides/2.6/user-guide/) has additional information and examples related to building and using Singularity containers.

Following are several other use cases:

*   Building containers with GUI support
*   Building an image with MPI support
*   Images with GPU support
*   Running Services
*   Using sandbox and writable images

_Building Containers with GUI Support_

A Singularity container can contain a GUI system so that the user can run a GUI application that may not easily be installed on Roar. Here is a simple example of a recipe that has a GUI available:

<pre class="script">Bootstrap: docker
From: centos:centos7
%post
yum -y upgrade
yum -y groupinstall "X Window System"
rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/
˓→yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/
˓→microsoft.asc" > /etc/yum.repos.d/vscode.repo
yum install -y nano emacs vim gedit kate nedit kwrite jed code
yum -y install which xorg-x11-fonts-Type1 liberation-sans-fonts
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install geany geany-plugins*
mkdir -p /storage/home
mkdir -p /storage/work
mkdir -p /gpfs/group
mkdir -p /gpfs/scratch
mkdir -p /var/spool/torque
mkdir -p /run/user/1000/dconf
touch /run/user/1000/dconf/user
%runscript
`

Here is a screenshot of an editor running within that container on an ACI-b compute node:

![](https://www.icds.psu.edu/wp-content/uploads/2018/11/UsingSingularityonACI-screenshot-1024x999.jpg)

_Building an Image with MPI Support_

Many HPC applications require the use of MPI. Singularity supports this; however, there are requirements for this:

*   Install InfiniBand libraries in the container
*   Make the MPI version available to the container, which may be accomplished by setting a bind path to the MPI location
*   The application must be linked the proper version of MPI

Here is an example of the MPI build file:

<pre class="script">BootStrap: yum
OSVersion: 7
MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/$basearch/
Include: yum
%setup
cd $SINGULARITY_ROOTFS/opt
wget http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz
wget http://lammps.sandia.gov/tars/lammps-stable.tar.gz
%post
yum -y groupinstall "Development Tools"
mkdir -p /opt/mpich
cd /opt/mpich
tar xf ../mpich-3.2.tar.gz --strip-components 1
./configure --prefix=/usr/local |& tee log.configure
make -j |& tee log.make
make install |& tee log.make_install
mkdir -p /opt/lammps
cd /opt/lammps
tar xf ../lammps-stable.tar.gz --strip-components 1
cd src
make yes-granular |& tee log.make_yes_granular
make -j mpi |& tee log.make_mpi
#ACI mappings so you can access your files.
mkdir -p /storage/home
mkdir -p /storage/work
mkdir -p /gpfs/group
mkdir -p /gpfs/scratch
mkdir -p /var/spool/torque
%runscript
/opt/lammps/src/lmp_mpi "$@"
`

Here is an example of an MPI run:

<pre class="script">[cjb47@comp-sc-0174 images]$ module load gcc/5.3.1 mpich/3.2
[cjb47@comp-sc-0174 images]$ mpirun --hostfile $PBS_NODEFILE -np 8 singularity run ./
˓→lammps_mpi.simg  in.friction
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
** NOTE: Singularity is in a testing phase on ACI-b and is currently unsupported.
LAMMPS (22 Aug 2018)
Lattice spacing in x,y,z = 1.1327 1.96189 1.1327
Created orthogonal box = (0 0 -0.283174) to (56.6348 43.1615 0.283174)
4 by 2 by 1 MPI processor grid
Created 750 atoms
Time spent = 0.00195265 secs
Created 750 atoms
Time spent = 0.00053978 secs
Created 112 atoms
Time spent = 0.000246286 secs
Created 112 atoms
Time spent = 0.0002985 secs
750 atoms in group lo
862 atoms in group lo
750 atoms in group hi
862 atoms in group hi
150 atoms in group lo-fixed
150 atoms in group hi-fixed
300 atoms in group boundary
1424 atoms in group mobile
Setting atom values ...
150 settings made for type
Setting atom values ...
150 settings made for type
WARNING: Temperature for thermo pressure is not for group all (../thermo.cpp:488)
Neighbor list info ...
update every 1 steps, delay 5 steps, check yes
max neighbors/atom: 2000, page size: 100000
master list distance cutoff = 2.8
ghost atom cutoff = 2.8
binsize = 1.4, bins = 41 31 1
1 neighbor lists, perpetual/occasional/extra = 1 0 0
(1) pair lj/cut, perpetual
attributes: half, newton on
pair build: half/bin/atomonly/newton
stencil: half/bin/2d/newton
bin: standard
Setting up Verlet run ...
Unit style : lj
Current step : 0
Time step : 0.0025
Per MPI rank memory allocation (min/avg/max) = 3.048 | 3.049 | 3.049 Mbytes
Step Temp E_pair E_mol TotEng Press Volume
0 0.1 -3.1333672 0 -3.0920969 -1.1437663 2444.9333
1000 0.1 -3.0917089 0 -3.0504386 -0.023690937 2444.9333
2000 0.082122114 -3.0852042 0 -3.0513121 -0.43261548 2444.9333
3000 0.081076017 -3.0813279 0 -3.0478675 -0.34285337 2444.9333
4000 0.094734274 -3.0722764 0 -3.0331792 -0.31676394 2444.9333
5000 0.11433917 -3.0594274 0 -3.0122393 -0.14791034 2444.9333
6000 0.11055427 -3.046338 0 -3.0007119 -0.22376263 2444.9333
7000 0.1 -3.045677 0 -3.0044067 -0.42807494 2444.9333
8000 0.11471279 -3.0383911 0 -2.9910488 -0.30901046 2444.9333
9000 0.11181441 -3.037818 0 -2.9916719 -0.41346773 2444.9333
10000 0.10709722 -3.0390765 0 -2.9948772 -0.27785942 2444.9333
11000 0.1 -3.0404147 0 -2.9991444 -0.50482354 2444.9333
12000 0.11767118 -3.0483134 0 -2.9997502 -0.12862642 2444.9333
13000 0.11773859 -3.0569926 0 -3.0084016 -0.36892682 2444.9333
14000 0.11272521 -3.0514207 0 -3.0048987 -0.36445405 2444.9333
15000 0.10522749 -3.0506428 0 -3.0072151 -0.35624388 2444.9333
16000 0.11015277 -3.0509982 0 -3.0055378 -0.19177436 2444.9333
17000 0.1081148 -3.0478773 0 -3.003258 -0.3475267 2444.9333
18000 0.11109139 -3.0476586 0 -3.0018109 -0.33148148 2444.9333
19000 0.10911522 -3.0523013 0 -3.0072692 -0.25645655 2444.9333
20000 0.11656944 -3.0534574 0 -3.0053488 -0.33684091 2444.9333
Loop time of 6.56253 on 8 procs for 20000 steps with 1724 atoms
Performance: 658283.185 tau/day, 3047.607 timesteps/s
74.8% CPU use with 8 MPI tasks x no OpenMP threads
MPI task timing breakdown:
Section | min time | avg time | max time |%varavg| %total
---------------------------------------------------------------
Pair | 0.4896 | 0.57526 | 0.75825 | 10.7 | 8.77
Neigh | 0.029521 | 0.03774 | 0.052896 | 4.3 | 0.58
Comm | 3.6847 | 4.1707 | 5.064 | 25.3 | 63.55
Output | 0.0028827 | 0.0031309 | 0.0033143 | 0.3 | 0.05
Modify | 0.076676 | 0.083922 | 0.09419 | 1.8 | 1.28
Other | | 1.692 | | | 25.78
Nlocal: 215.5 ave 286 max 189 min
Histogram: 5 1 0 0 0 0 0 0 1 1
Nghost: 97.875 ave 131 max 77 min
Histogram: 2 1 1 1 1 0 0 0 1 1
Neighs: 1802 ave 2442 max 1569 min
Histogram: 5 1 0 0 0 0 0 0 1 1
Total # of neighbors = 14416
Ave neighs/atom = 8.36195
Neighbor list builds = 720
Dangerous builds = 0
Total wall time: 0:00:06
`

_Images with GPU Support_

You can build a Singularity image with GPU support or find a pre-built one. You will need to make sure the version of CUDA that is to be used (i.e., the version of the CUDA that will be in the environment, check GPU documentation for more information) matches that of the image you plan to use. The [Official Singularity User Guide](http://singularity.lbl.gov/docs-instances) has more details.

Note that many services require sudo access and thus cannot be run on Roar.

_Running Services_

In some cases, a piece of software, such as database or web server, is meant to be run in the background and accessed as a server. In some cases, it is possible to run these as an instance.

_Using Sandbox and Writable Images_

Recipes are the most reproducible method of preparing images, but you can use writable and sandbox images to build the image interactively. By default, all Singularity images are temporary, which means changes are not retained when the image is stopped (i.e., when  
the shell is exited, the command has completed running, or the instance is stopped by the `instance.stop` command).

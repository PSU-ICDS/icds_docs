---
title: Application Development
---

  

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

##### <span class="titlemark">6.3.1</span> MKL

Intel Math Kernel Library (MKL) consists of commonly used mathematical operations in computational science. The functions in MKL are optimized for use on Intel processors. More information can be found [here.](https://software.intel.com/en-us/mkl)  

The MKL module can be loaded using the command

`module load mkl`

##### <span class="titlemark">6.3.2</span> LAPACK

LAPACK (Linear Algebra Package) is a software library used for numerical linear algebra. It can handle many common numerical algebra computations such as solving linear systems, eigenvalue problems, and matrix factorization. It depends on BLAS. More information can be found on the [website.](http://www.netlib.org/lapack/)  

You can load the LAPACK module using the commands:

`module load gcc/5.3.1
module load lapack/3.6.0
`

##### <span class="titlemark">6.3.3</span> BLAS

BLAS (Basic Linear Algebra Subprograms) is a collection of low level matrix and vector operations such as vector addition, scalar multiplication, matrix multiplication, etc. For more information, refer to this [link.](http://www.netlib.org/blas/)  

The BLAS module can be loaded with the command

`module load blas`

##### <span class="titlemark">6.3.5</span> Boost

Boost is a C++ library that contains many useful functions covering a wide range of applications such as linear algebra and multithreading. More information can be found [here.](http://www.boost.org/)

You can load Boost with the command

`module load boost`

##### <span class="titlemark">6.3.6</span> PETsc

The Portable, Extensible Toolkit for Scientific Computation (PETsc, pronounced PET-see) is a suite of data structures and routines for solving partial differential equations and sparse matrices in a parallel fashion that is scalable. It was developed by Argonne National Laboratory.  

You can load the PETsc module using the command

`module load petsc/3.8.3`

More information on features, tutorials, manuals, etc can be found on the [website.](http://www.mcs.anl.gov/petsc/)

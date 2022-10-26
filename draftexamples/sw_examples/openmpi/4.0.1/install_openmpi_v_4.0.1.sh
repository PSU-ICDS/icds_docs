#!/bin/bash

# install openmpi version 4.0.1
# with spack
# installs in /storage/work/$USER/sw

# once installed load and unload openmpi like a module:
#  $ spack load openmpi
#  $ spack unload openmpi

# make a dir to store spack
SW_PATH=/storage/work/$USER/sw
mkdir -p $SW_PATH
cd $SW_PATH

# load required modules (specify gcc version if you want)
# module load gcc/{version}
module load python/2.7.14-anaconda5.0.1 

# install spack
git clone https://github.com/spack/spack.git
SPACK_ROOT=$SW_PATH/spack
export PATH=$SPACK_ROOT/bin:$PATH
spack install libelf

# install openmpi
spack install openmpi@4.0.1

# initialize spack's shell commands
. $SPACK_ROOT/share/spack/setup-env.sh

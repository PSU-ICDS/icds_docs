#!/bin/bash

# This script installs nlopt in /storage/work/$(whoami)/sw/avro

# Module Setup
module purge
module load cmake
module list


# Set up workspace
BASE=/storage/work/$(whoami)
if [ ! -d "sw" ]
then
    mkdir sw
fi
cd $BASE/sw


# Install NLOPT
if [ ! -d "nlopt-2.6.1" ] 
then
    wget https://github.com/stevengj/nlopt/archive/v2.6.1.tar.gz
    tar -xvf v2.6.1.tar.gz
    rm v2.6.1.tar.gz
    cd nlopt-2.6.1
    mkdir install
    cmake -DCMAKE_INSTALL_PREFIX=$BASE/sw/nlopt-2.6.1/install .
    make
    make install
fi
export NLOPT_INCLUDE_DIRS=$BASE/sw/nlopt-2.6.1/install/include
export NLOPT_LIBRARIES=$BASE/sw/nlopt-2.6.1/install/lib64

#!/bin/bash


# This script installs avro and dependencies in /storage/work/$(whoami)/sw/avro
# avro is available for download here: https://drive.google.com/file/d/1E6csczVUBibU5yWO6K8-sYouV687MPHE/view
# Emery Etter and Justin Petucci
# 04-2020


# Module Setup
module purge
module load cmake
module load gcc/5.3.1 boost openmpi zlib
module load lapack
module list


# BOOST
. /gpfs/group/dmw72/default/load_BOOST_KG


# EngineeringSketchPad
export ESP_DIR=/gpfs/group/dmw72/default/SANS_/SANS_Adaptive/ESP117/EngSketchPad
export CAS_DIR=/gpfs/group/dmw72/default/SANS_/SANS_Adaptive/ESP117/OpenCASCADE-7.3.1


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


# Download AVRO
cd $BASE/sw
if [ ! -d "avro" ]
then
    wget -O avro.tgz 'https://drive.google.com/u/0/uc?id=1E6csczVUBibU5yWO6K8-sYouV687MPHE&export=download'
    tar -xvf avro.tgz
    rm avro.tgz
    cd avro
    sed -i 's/blas//g' $BASE/sw/avro/src/CMakeLists.txt
fi


# Build AVRO
mkdir -p $BASE/sw/avro/build/release
cd $BASE/sw/avro/build/release
export LIBRARY_PATH=/usr/lib64:$LIBRARY_PATH
export PATH=/opt/aci/sw/openmpi/1.10.1_gcc-5.3.1/bin:$PATH

cmake -DCMAKE_INSTALL_PREFIX=$BASE/sw/avro -DNLOPT_INCLUDE_DIRS=$BASE/sw/nlopt-2.6.1/install/include -DNLOPT_LIBRARIES=$BASE/sw/nlopt-2.6.1/install/lib64/libnlopt.so -DLAPACK_LIBRARIES=/opt/aci/sw/lapack/3.6.0_gcc-5.3.1/usr/lib64/liblapack.so -DAVRO_RUN_WITH_MPI=ON -DAVRO_WITH_MPI=ON -DWITH_MPI=ON -DMPI_C_COMPILER=/opt/aci/sw/openmpi/1.10.1_gcc-5.3.1/bin/mpicc -DMPI_CXX_COMPILER=/opt/aci/sw/openmpi/1.10.1_gcc-5.3.1/bin/mpicxx -DCMAKE_C_COMPILER=/opt/aci/sw/openmpi/1.10.1_gcc-5.3.1/bin/mpicc -DCMAKE_EXE_LINKER_FLAGS='-L/opt/aci/sw/zlib/1.2.11_gcc-5.3.1/lib/libz.so -static-libstdc++' ../../

make avro

#make all
#make unit

# run the following to test avro with mpi
#cd ../../test
#mpirun -np 2 ../build/release/bin/avro -adapt data/cube.mesh box Linear-3d tmp/cl.mesh


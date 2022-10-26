#!/bin/bash

# create directory structure for install
BASE=/storage/work/$USER/sw/basemap
mkdir -p $BASE
cd $BASE

# module setup
module purge
module load python gcc

# create basemap-env
conda create -y -n basemap-env python=3 numpy matplotlib pyproj pyshp geos

# jump into basemap-env
source activate basemap-env

# download and extract install files
wget https://github.com/matplotlib/basemap/archive/v1.1.0.tar.gz
tar -xvf $BASE/v1.1.0.tar.gz
echo "\n\nDone extracting files...\n\n"

# install geos 3.3.3
#cd $BASE/basemap-1.1.0/geos-3.3.3
#export GEOS_DIR=$BASE/basemap-1.1.0/geos-3.3.3
#./configure --prefix=$GEOS_DIR
#make; make install

# install basemap 1.1.0
cd $BASE/basemap-1.1.0
python setup.py install
python examples/simpletest.py

#!/bin/bash
# Script to install ncview with NetCDF 4.6.2
# Written by Ghanghoon "Will" Paik (gip5038@psu.edu)
# Feb 19 2019

module load gcc/5.3.1
module load hdf5

BASE=$PWD

wget ftp://cirrus.ucsd.edu/pub/ncview/ncview-2.1.7.tar.gz
wget ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.2.26.tar.gz
wget https://github.com/Unidata/netcdf-c/archive/v4.6.2.tar.gz

wget http://mirror.centos.org/centos/6/os/x86_64/Packages/Xaw3d-devel-1.5E-15.1.el6.x86_64.rpm
rpm2cpio Xaw3d-devel-1.5E-15.1.el6.x86_64.rpm | cpio -idmv
wget http://mirror.centos.org/centos/6/os/x86_64/Packages/libXaw-devel-1.0.11-2.el6.x86_64.rpm
rpm2cpio libXaw-devel-1.0.11-2.el6.x86_64.rpm | cpio -idmv
wget http://mirror.centos.org/centos/6/os/x86_64/Packages/libXaw-1.0.11-2.el6.x86_64.rpm
rpm2cpio libXaw-1.0.11-2.el6.x86_64.rpm | cpio -idmv
wget http://mirror.centos.org/centos/6/os/x86_64/Packages/Xaw3d-1.5E-15.1.el6.x86_64.rpm
rpm2cpio Xaw3d-1.5E-15.1.el6.x86_64.rpm | cpio -idmv
wget http://mirror.centos.org/centos/6/os/x86_64/Packages/libXmu-1.1.1-2.el6.x86_64.rpm
rpm2cpio libXmu-1.1.1-2.el6.x86_64.rpm | cpio -idmv
wget http://mirror.centos.org/centos/6/os/x86_64/Packages/libXmu-devel-1.1.1-2.el6.x86_64.rpm
rpm2cpio libXmu-devel-1.1.1-2.el6.x86_64.rpm | cpio -idmv

rm ./*.rpm

mv usr ncview
BUILD_DIR=$BASE/ncview


tar -xf ncview-2.1.7.tar.gz
tar -xf udunits-2.2.26.tar.gz
tar -xf v4.6.2.tar.gz

cd netcdf-c-4.6.2
./configure --prefix=$BUILD_DIR/
make
make install

cd $BASE/udunits-2.2.26
./configure --prefix=$BUILD_DIR/
make
make install

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$BUILD_DIR/lib/pkgconfig
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$BUILD_DIR/lib:$BUILD_DIR/lib64
export CPATH=$CPATH:$BUILD_DIR/include
export PATH=$PATH:$BUILD_DIR/bin

cd $BASE/ncview-2.1.7
./configure --prefix=$BUILD_DIR --with-udunits2_incdir=$BUILD_DIR/include --with-udunits2_libdir=$BUILD_DIR/lib --with-nc-config=$BUILD_DIR/bin/nc-config CPPFLAGS="-I$BUILD_DIR/include" LDFLAGS="-L$BUILD_DIR/lib64"
make
make install

rm ./*.tar.gz
rm -rf ncview-2.1.7 netcdf-c-4.6.2 udunits-2.2.26 
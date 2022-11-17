
# This is a script to install NetCDF in R within a user's space on Roar
# Written by Emery Etter -- 202002

# clear out modules
module purge

# load necessary modules
module load gcc

# set up installation workspace
PSUID=$(whoami)
cd /storage/work/$PSUID/
mkdir -p sw/r_ncdf
BASE=/storage/work/$PSUID/sw/r_ncdf
cd $BASE

# set versions to be downloaded and installed
ZLIB_VER=1.2.8
HDF5_VER=1.8.13
NETCDF_VER=4.4.1

# download and install zlib (a dependency of netcdf)
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/zlib-${ZLIB_VER}.tar.gz
tar -xf zlib-${ZLIB_VER}.tar.gz && cd zlib-${ZLIB_VER}
./configure --prefix=../zlib
make install
cd ../zlib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD/lib
cd ..
rm zlib-${ZLIB_VER}.tar.gz
rm zlib-${ZLIB_VER} -rf
echo -e "\n\n  -->  ZLIB ${ZLIB_VER} installation complete!\n\n"

# download and install hdf5 (a dependency of netcdf)
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/hdf5-${HDF5_VER}.tar.gz
tar -xf hdf5-${HDF5_VER}.tar.gz && cd hdf5-${HDF5_VER}
export HDF5_DIR="${BASE}/hdf5"
./configure --enable-shared --enable-hl --prefix=$HDF5_DIR
make -j4
make install
cd $HDF5_DIR
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD/lib
export PATH=$PATH:$PWD/bin
cd ..
rm hdf5-${HDF5_VER}.tar.gz
rm hdf5-${HDF5_VER} -rf
echo -e "\n\n  -->  HDF5 ${HDF5_VER} installation complete!\n\n"

# download and install netcdf
wget http://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-${NETCDF_VER}.tar.gz
tar -xf netcdf-${NETCDF_VER}.tar.gz && cd netcdf-${NETCDF_VER}
export NETCDF4_DIR="${BASE}/netcdf"
CPPFLAGS=-I$HDF5_DIR/include LDFLAGS=-L$HDF5_DIR/lib ./configure --enable-netcdf-4 --enable-shared --enable-dap --prefix=$NETCDF4_DIR
make -j4
make install
cd $NETCDF4_DIR
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NETCDF4_DIR/lib
export PATH=$PATH:$NETCDF4_DIR/bin
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$NETCDF4_DIR/lib/pkgconfig
cd ..
rm netcdf-${NETCDF_VER}.tar.gz
rm netcdf-${NETCDF_VER} -rf
echo -e "\n\n  -->  NetCDF ${NETCDF_VER} installation complete!\n\n"

# load r module and install ncdf library
module load r
cd $BASE
wget http://cirrus.ucsd.edu/~pierce/ncdf/ncdf4_1.13.tar.gz
R CMD INSTALL ncdf4_1.13.tar.gz --library=.
rm ncdf4_1.13.tar.gz
echo -e "\n\n  -->  NCDF4 1.13 R installation complete!\n\n"

# after installing, run the following commands to open R and load ncdf4:
# (note: the ${BASE} variable must be fully typed out since it will be out of scope)
#R
#library("ncdf4",lib.loc="${BASE}")


#!/bin/bash

# RGDAL Installer for PSU ICDS-ACI
# Emery Etter 2020/04/06


# - - - - - set all versions - - - - -
SP_VER=1.4-1
PROJ_VER=7.0.0
GDAL_VER=2.4.4


# - - - - - set up workspace - - - - -
cd /storage/work/$(whoami)
mkdir -p sw/rgdal
BASE=/storage/work/$(whoami)/sw/rgdal
mkdir -p sw/rpkg
INSTALL_DIR=/storage/work/$(whoami)/sw/rpkg
cd $BASE


# - - - - - load necessary modules - - - - - 
module load r gcc python


# - - - - - download packages - - - - -

# download sqlite3
if [ ! -d sqlite-autoconf-3310100 ]
then
    wget https://www.sqlite.org/2020/sqlite-autoconf-3310100.tar.gz
    tar -xvf sqlite-autoconf-3310100.tar.gz
    rm sqlite-autoconf-3310100.tar.gz
fi

# download sp
if [ ! -f sp_$SP_VER.tar.gz ]
then
    wget https://cran.r-project.org/src/contrib/sp_$SP_VER.tar.gz
fi

# download proj
if [ ! -d proj-$PROJ_VER ]
then
    wget https://download.osgeo.org/proj/proj-$PROJ_VER.tar.gz
    tar -xvf proj-$PROJ_VER.tar.gz
    rm proj-$PROJ_VER.tar.gz
fi

# download gdal
if [ ! -d gdal-$GDAL_VER ]
then
    wget https://download.osgeo.org/gdal/$GDAL_VER/gdal-$GDAL_VER.tar.gz
    tar -xvf gdal-$GDAL_VER.tar.gz
    rm gdal-$GDAL_VER.tar.gz
fi


# - - - - - install r packages - - - - -

# install sqlite3
cd sqlite-autoconf-3310100
./configure --prefix=$INSTALL_DIR/sqlite
make check
make install
printf "\n\nSQLITE INSTALLATION COMPLETE\n\n\n"

# install sp
cd $BASE
R CMD INSTALL sp_$SP_VER.tar.gz --library=$INSTALL_DIR
rm $BASE/sp_$SP_VER.tar.gz
printf "\n\nSP INSTALLATION COMPLETE\n\n\n"

# install proj
cd $BASE/proj-$PROJ_VER
mkdir $INSTALL_DIR/proj
./configure --prefix=$INSTALL_DIR/proj SQLITE3_CFLAGS="-I$INSTALL_DIR/sqlite/include" SQLITE3_LIBS="-L$INSTALL_DIR/sqlite/lib -lsqlite3" --with-sqlite3=$INSTALL_DIR/sqlite/bin/sqlite3
make check
make install
printf "\n\nPROJ INSTALLATION COMPLETE\n\n\n"

# R environment
export R_LIBS_USER=$INSTALL_DIR

# proj environment
export LD_LIBRARY_PATH=$INSTALL_DIR/proj-$PROJ_VER/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$INSTALL_DIR/proj-$PROJ_VER/lib:$LIBRARY_PATH
export CPATH=$INSTALL_DIR/proj-$PROJ_VER/include:$CPATH
export PATH=$INSTALL_DIR/proj-$PROJ_VER/bin:$PATH
export PKG_CONFIG_PATH=$INSTALL_DIR/proj-$PROJ_VER/lib/pkgconfig:$PKG_CONFIG_PATH

# install gdal
cd $BASE/gdal-$GDAL_VER
mkdir $INSTALL_DIR/gdal
export LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH
./configure --with-curl=no --prefix=$INSTALL_DIR/gdal
make install

# gdal environment
export PATH=$INSTALL_DIR/gdal-$GDAL_VER/bin:$PATH
export LD_LIBRARY_PATH=$INSTALL_DIR/gdal-$GDAL_VER/lib:$LD_LIBRARY_PATH
export GDAL_DATA=$INSTALL_DIR/gdal-$GDAL_VER/share/gdal

printf "\n\nGDAL INSTALLATION COMPLETE\n\n\n"


# run environment setup script in order to use rgdal
#. rgdal_setup.sh

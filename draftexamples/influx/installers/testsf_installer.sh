#!/bin/bash

########################################
########################################

package="sf (R package) Installer"
command="./sf_installer.sh"
version="1.0"
verdate="2021-08-17"
preview="An installer for the sf R package and relevant dependencies."
summary="To install the sf R package, several dependencies are required. The dependencies sqlite3, GEOS, PROJ, and GDAL are installed, and then the sf R package is installed for R/4.0.3."

#    Copyright (c) 2021 Emery Etter
#
#    Permission is hereby granted, free of charge, to any person obtaining a copy
#    of this software and associated documentation files (the "Software"), to deal
#    in the Software without restriction, including without limitation the rights
#    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#    copies of the Software, and to permit persons to whom the Software is
#    furnished to do so, subject to the following conditions:
#
#    The above copyright notice and this permission notice shall be included in all
#    copies or substantial portions of the Software.
#
#    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#    SOFTWARE.

########################################
########################################


########################################

#### DEFAULTS ####

set_defaults() {

# establish defaults
#GDAL_VERSION_DEFAULT determined by the GDAL github page
#GEOS_VERSION_DEFAULT determined by the GEOS github page
proj_version_default="7.1.0"
sqlite_version_default="3.36.0"
sf_version_default="1.0-2"

BASE_INSTALL_DIR_DEFAULT="/storage/work/$(whoami)/sw"
PACKAGE_LIST_DEFAULT="sqlite geos proj gdal sf"

# set defaults
proj_version=${proj_version_default}
sqlite_version=${sqlite_version_default}
sf_version=${sf_version_default}
#BASE_INSTALL_DIR=${BASE_INSTALL_DIR_DEFAULT}
#PACKAGE_LIST=${PACKAGE_LIST_DEFAULT}

}

########################################


########################################

#### INFORMATION ####

usage() {

    echo ""
    echo "$package [v$version] - $preview"
    echo " "
    echo "$command [options] [arguments]"
    echo " "
    echo "options:"
    echo "    -h, --help                show brief help"
    echo "    -v, --version             show version information"
    echo "    -i, --intall-dir=DIR      specify the install directory"
    echo ""

}


version() {

    echo ""
    echo "Script Title:  $package"
    echo "Version:       $version"
    echo "Release Date:  $verdate"
    echo ""

}


title() {

    echo ""
    echo "$package - $preview"
    echo ""
    echo "Description:   $summary"
    echo ""

}

########################################


########################################

#### MAIN ####

main() {

    # initializations
    set_defaults
    setup_colors

    # command line inputs
    parse_params "$@"
    
    # script process
    kickoff
    process

    # finish up
    finalreport
    cleanup

}

########################################


########################################

#### PARSE PARAMETERS ####

parse_params() {

    # parameter values
    BASE_INSTALL_DIR_IN=""

    while test $# -gt 0; do
	case "$1" in
	    
	    # summary info
	    -h | --help )
		usage
		exit 0
		;;
	    -v | --version )
		version
		exit 0
		;;
	    --no-color )
		NO_COLOR_1
		shift
		;;
	    
	    # file management
	    -i )
		shift
		if test $# -gt 0; then
		    BASE_INSTALL_DIR_IN=$1
		else
		    msg_error "No install directory specified."
		    exit 1
		fi
		shift
		;;
	    --install-dir* )
		BASE_INSTALL_DIR_IN=`echo $1 | sed -e 's/^[^=]*=//g'`
		msg_info "Installation directory set to ${BASE_INSTALL_DIR_IN}"
		shift
		;;

	    --packages* )
		PACKAGE_LIST_IN=`echo $1 | sed -e 's/^[^=]*=//g'`
		msg_info "Packages to be installed:  ${PACKAGE_LIST_IN}"
		
		shift
		;;

	    # flags
	    # NONE
	    
	    # other actions
	    # NONE

	    # unknown option
	    -?* )
		die "Unkown option:  ${1}"
		exit 1
		;;

	    # empty
	    * )
		break
		;;
	    
	esac
    done
    
    if check4params; then
	display_params
	msg_info "Checking input parameters..."
	check_params
    else
	msg_info "No input parameters provided. Using default values."
    fi

}


check4params() {

    if [[ "${BASE_INSTALL_DIR_IN}" == "" && "${PACKAGE_LIST_IN}" == "" ]]; then
	return 1    # no input parameters provided
    else
	return 0    # input parameters have been provided
    fi

}


check_params() {

    if [[ "${BASE_INSTALL_DIR_IN}" == "" ]]; then
	BASE_INSTALL_DIR=${BASE_INSTALL_DIR_DEFAULT}
    else
	BASE_INSTALL_DIR=${BASE_INSTALL_DIR_IN}
    fi
    
    if [[ -d "${BASE_INSTALL_DIR}" ]]; then
	msg_info "Installation directory found. Packages will be installed in ${BASE_INSTALL_DIR}"
    else
	msg_error "Installation directory NOT found. Attempting to create it now..."
	mkdir -p ${BASE_INSTALL_DIR}
	if [[ $? -eq 0 ]]; then
	    msg_info "Installation directory created. Packages will be installed in ${BASE_INSTALL_DIR}"
	else
	    msg_error "Installation directory could not be found and could not be created. Using default installation directory ${BASE_INSTALL_DIR_DEFAULT}"
	    BASE_INSTALL_DIR=$BASE_INSTALL_DIR_DEFAULT
	    mkdir -p ${BASE_INSTALL_DIR}
	    if [[ $? -eq 1 ]]; then die "Installation directory could not be set."; fi
	fi
    fi

   if [[ "${PACKAGE_LIST_IN}" == "" ]]; then
       PACKAGE_LIST=${PACKAGE_LIST_DEFAULT}
   else
       PACKAGE_LIST=${PACKAGE_LIST_IN}
   fi

}


display_params() {
    
    echo ""
    echo " - - - - - - - - - - - - - - - - - - - -"
    echo ""
    msg_headline "Provided Input Parameters..."
    echo ""
    if [[ "${BASE_INSTALL_DIR_IN}" != "" ]]; then
	msg_info "Install directory:  ${BASE_INSTALL_DIR_IN}"
    fi
    if [[ "${PACKAGE_LIST_IN}" != "" ]]; then
	msg_info "Package list:       ${PACKAGE_LIST_IN}"
    fi
    echo ""
    echo " - - - - - - - - - - - - - - - - - - - -"
    echo ""

}

########################################


########################################

#### FUNCTIONS ####

process() {

    module purge
    module list

    # retrieve some information
    script_location

    # setup
    set_dl_locations
    set_install_locations

    # set vars

    # run installs
    for i in ${PACKAGE_LIST}; do
	install_${i}
	setvars_${i}
    done

}


script_location() {

    script_dir=$( cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P )
    run_dir=$(pwd)
    run_pdir=$(pwd -P)

}


die() {

  local msg=$1
  local code=${2-1} # default exit status 1
  msg_error "$msg"
  exit "$code"

}


cleanup() {

    # Ignore signals listed, no Ctrl-C allowed.
    trap "" SIGINT SIGTERM ERR EXIT
    
    # Reset signals listed to default value, Ctrl-C allowed.
    trap - SIGINT SIGTERM ERR EXIT

}


set_dl_locations() {

    gdal_source_dl="https://github.com/OSGeo/gdal"
    geos_source_dl="https://git.osgeo.org/gitea/geos/geos.git"
    proj_source_dl="https://download.osgeo.org/proj/proj-${proj_version}.tar.gz"
    sqlite_source_dl="https://www.sqlite.org/2021/sqlite-autoconf-3360000.tar.gz"

}


set_install_locations() {

    sqlite_install_dir="${BASE_INSTALL_DIR}"/sqlite
    geos_install_dir="${BASE_INSTALL_DIR}"/geos
    proj_install_dir="${BASE_INSTALL_DIR}"/proj
    gdal_install_dir="${BASE_INSTALL_DIR}"/gdal
    sf_install_dir="${BASE_INSTALL_DIR}"/Rpkgs

}


install_sqlite() {
    
    echo ""
    msg_headline "Installing SQLite3..."
    echo ""

    module purge
    module load gcc/8.3.1

    mkdir -p ${sqlite_install_dir}
    cd ${sqlite_install_dir}
    wget ${sqlite_source_dl}
    tar -xvf sqlite-autoconf-3360000.tar.gz
    cd sqlite-autoconf-3360000
    ./configure --prefix=${sqlite_install_dir}
    make install
    if [[ $? -ne 0 ]]; then die "SQLite3 installation failed."; fi
    rm "${sqlite_install_dir}"/sqlite-autoconf-3360000.tar.gz

    echo ""
    msg_complete "SQLite3 v${sqlite_version} installation complete."
    echo ""

}


setvars_sqlite() {

    export PATH=${sqlite_install_dir}/bin:$PATH

}


install_geos() {

    echo ""
    msg_headline "Installing GEOS..."
    echo ""

    module purge
    module load gcc/8.3.1 cmake/3.18.4

    mkdir -p ${geos_install_dir}
    cd ${geos_install_dir}
    git clone ${geos_source_dl}
    cmake geos -DCMAKE_INSTALL_PREFIX=${geos_install_dir}
    make
    if [[ $? -ne 0 ]]; then die "GEOS installation failed."; fi
    make install
    if [[ $? -ne 0 ]]; then die "GEOS installation failed."; fi

    echo ""
    msg_complete "GEOS installation complete."
    echo ""


}


setvars_geos() {

    msg_info "No variables to set for geos..."

}


install_proj() {

    echo ""
    msg_headline "Installing PROJ..."
    echo ""

    module purge
    module load gcc/8.3.1

    mkdir -p ${proj_install_dir}
    cd ${proj_install_dir}
    wget ${proj_source_dl}
    tar -xvf proj-${proj_version}.tar.gz
    cd proj-${proj_version}
    export LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH
    ./configure --prefix=${proj_install_dir} SQLITE3_CFLAGS="-I${sqlite_install_dir}/include" SQLITE3_LIBS="-L${sqlite_install_dir}/lib -lsqlite3"
    make
    if [[ $? -ne 0 ]]; then die "PROJ installation failed."; fi
    make install
    if [[ $? -ne 0 ]]; then die "PROJ installation failed."; fi
    rm "${proj_install_dir}"/proj-${proj_version}.tar.gz

    echo ""
    msg_complete "PROJ v${proj_version} installation complete."
    echo ""


}


setvars_proj() {

    # proj environment
    export LD_LIBRARY_PATH=${proj_install_dir}/lib:$LD_LIBRARY_PATH
    export LIBRARY_PATH=${proj_install_dir}/lib:$LIBRARY_PATH
    #export CPATH=${proj_install_dir}/include:$CPATH
    export PATH=${proj_install_dir}/bin:$PATH
    export PKG_CONFIG_PATH=${proj_install_dir}/lib/pkgconfig:$PKG_CONFIG_PATH

}


install_gdal() {

    echo ""
    msg_headline "Installing GDAL..."
    echo ""

    module purge
    module load gcc/8.3.1

    mkdir -p ${gdal_install_dir}
    cd ${gdal_install_dir}
    git clone ${gdal_source_dl}
    cd gdal/gdal
    ./configure --prefix=${gdal_install_dir} --with-proj=${proj_install_dir} --with-sqlite3=${sqlite_install_dir} --with-geos=${geos_install_dir}/bin/geos-config
    make
    make install
    if [[ $? -ne 0 ]]; then die "GDAL installation failed."; fi

    echo ""
    msg_complete "GDAL installation complete."
    echo ""

}


setvars_gdal() {
 
    # gdal environment
    export PATH=${gdal_install_dir}/bin:$PATH
    export LD_LIBRARY_PATH=${gdal_install_dir}/lib:$LD_LIBRARY_PATH
    export GDAL_DATA=${gdal_install_dir}/share/gdal

}


install_sf() {

    echo ""
    msg_headline "Installing sf in R..."
    echo ""

    module purge
    module use /gpfs/group/RISE/sw7/modules
    module load r/4.0.3

    export R_LIBS_USER=${BASE_INSTALL_DIR}/Rpkgs
    mkdir -p ${sf_install_dir}
    cd ${R_LIBS_USER}
    wget https://cloud.r-project.org/src/contrib/sf_${sf_version}.tar.gz
    R CMD INSTALL sf_${sf_version}.tar.gz --library=${sf_install_dir}
    if [[ $? -ne 0 ]]; then die "sf installation failed."; fi
    rm ${R_LIBS_USER}/sf_${sf_version}.tar.gz
    
    echo ""
    msg_complete "sf installation complete."
    echo ""
    
}


setvar_sf() {

    msg_info "No variables to set for sf..."

}


########################################


########################################

#### MESSAGING ####


kickoff() {

    title    

}


finalreport() {

    msg_complete "All packages installed successfully in ${BASE_INSTALL_DIR}"

}


setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}


msg() {
  echo >&2 -e "  ${1-}"
}

msg_error() {
  echo >&2 -e "  ${RED}${1-}${NOFORMAT}"
}

msg_headline() {
  echo >&2 -e "  ${BLUE}${1-}${NOFORMAT}"
}

msg_info() {
  echo >&2 -e "  ${NOFORMAT}${1-}${NOFORMAT}"
}

msg_complete() {
  echo >&2 -e "  ${GREEN}${1-}${NOFORMAT}"
}


########################################


########################################

#### RUN SCRIPT ####

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT
main "$@"; exit

########################################


####  Emery Etter
####  Institute for Computational and Data Science
####  Penn State University

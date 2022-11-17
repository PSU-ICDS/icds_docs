#!/bin/bash

########################################
########################################

package="sf (R package) Installer"
command="bash sf_installer.sh"
version="1.0"
verdate="2021-08-19"
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

# bash sf_installer.sh --install-dir=/gpfs/scratch/ece5034/installdir --setvars="sqlite geos proj gdal" --packages="s2 sf"

########################################

#### DEFAULTS ####

set_defaults() {

# establish default versions
#GDAL_VERSION_DEFAULT determined by the GDAL github page
#GEOS_VERSION_DEFAULT determined by the GEOS github page
proj_version_default="7.1.0"
sqlite_version_default="3.36.0"
s2_version_default="1.0.5"
sf_version_default="1.0-2"

# establish default input parameters
BASE_INSTALL_DIR_DEFAULT="/storage/work/$(whoami)/sw"
PACKAGE_LIST_DEFAULT=( sqlite geos proj gdal s2 sf )
SETVARS_LIST_DEFAULT=""

# set defaults
proj_version=${proj_version_default}
sqlite_version=${sqlite_version_default}
s2_version=${s2_version_default}
sf_version=${sf_version_default}
BASE_INSTALL_DIR=${BASE_INSTALL_DIR_DEFAULT}

# set string delimiter
IFS=' '

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
    echo "    --packages=PACKAGES       specify which packages should be installed [default: \"sqlite geos proj gdal sf\"]"
    echo "                                   note:  the interdependence of the packages requires this specific list ordering"
    echo "    --setvars=PACKAGES        specify which packages are already installed so the environment variables can be properly set"
    echo "                                   note:  any packages not to be installed should be specified here"
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
    echo "- - - - - - - - - - - - - - - - - - - -"
    echo ""
    msg_headline "    $package"
    echo ""
    msg_headline " $preview"
    echo ""
    msg_headline " $summary"
    echo ""
    echo "- - - - - - - - - - - - - - - - - - - -"
    echo ""

}

########################################


########################################

#### MAIN ####

main() {

    # initializations
    set_defaults
    setup_colors

    kickoff

    # parse command line inputs
    parse_params "$@"
    
    # script process
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
    PACKAGE_LIST_IN=""
    SETVARS_LIST_IN=""

    # parser
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
		msg_info "Installation directory:      ${BASE_INSTALL_DIR_IN}"
		shift
		;;

	    --packages* )
		PACKAGE_LIST_IN_STRING=`echo $1 | sed -e 's/^[^=]*=//g'`
		read -a PACKAGE_LIST_IN <<< "${PACKAGE_LIST_IN_STRING}"
		msg_info "Packages to be installed:    ${PACKAGE_LIST_IN[*]}"
		shift
		;;

	    --setvars* )
		SETVARS_LIST_IN_STRING=`echo $1 | sed -e 's/^[^=]*=//g'`
		read -a SETVARS_LIST_IN <<< "${SETVARS_LIST_IN_STRING}"
                msg_info "Packages already installed:  ${SETVARS_LIST_IN[*]}"
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
    
    # determine inputs, if any, and set values accordingly
    if check4params; then
	display_params
	msg_info "Checking input parameters..."
	check_params
    else
	msg_info "No input parameters provided. Using default values."
    fi

}


check4params() {

    if [[ "${BASE_INSTALL_DIR_IN}" == "" && "${PACKAGE_LIST_IN}" == "" && "${SETVARS_LIST_IN}" == "" ]]; then
	return 1    # no input parameters provided
    else
	return 0    # input parameters have been provided
    fi

}


check_params() {

    # set installation directory
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

    # set packages to be installed
    if [[ "${PACKAGE_LIST_IN}" == "" ]]; then
        PACKAGE_LIST=("${PACKAGE_LIST_DEFAULT[@]}")
    else
        PACKAGE_LIST=("${PACKAGE_LIST_IN[@]}")
    fi

    # set which packages are already installed
    if [[ "${SETVARS_LIST_IN}" == "" ]]; then
        SETVARS_LIST=("${SETVARS_LIST_DEFAULT[@]}")
    else
        SETVARS_LIST=("${SETVARS_LIST_IN[@]}")
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
	msg_info "Install packages:   ${PACKAGE_LIST_IN[*]}"
    fi
    if [[ "${SETVARS_LIST_IN}" != "" ]]; then
	msg_info "Set variables for:  ${SETVARS_LIST_IN[*]}"
    fi
    echo ""
    echo " - - - - - - - - - - - - - - - - - - - -"
    echo ""

}

########################################


########################################

#### FUNCTIONS ####

process() {

    # check software loads from software stack
    module purge
    echo ""
    module list
    echo ""

    # setup
    script_location
    set_dl_locations
    set_install_locations

    # setvars for installed packages
    if [[ "${SETVARS_LIST}" != "" ]]; then
	for sv in "${SETVARS_LIST[@]}"; do
	    setvars_${sv}
	done
    fi

    # run installs
    for i in "${PACKAGE_LIST[@]}"; do
	install_${i}
	setvars_${i}
    done

    # setup environment variables for future logins
    if [[ "${SETVARS_LIST}" != "" ]]; then    
	login_env_setup
    fi

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
 
    sqlite_source_dl="https://www.sqlite.org/2021/sqlite-autoconf-3360000.tar.gz"
    geos_source_dl="https://git.osgeo.org/gitea/geos/geos.git"
    proj_source_dl="https://download.osgeo.org/proj/proj-${proj_version}.tar.gz"
    gdal_source_dl="https://github.com/OSGeo/gdal"
    #s2_source_dl="https://cran.r-project.org/src/contrib/Archive/s2/s2_${s2_version}.tar.gz"  # archive version
    s2_source_dl="https://cran.r-project.org/src/contrib/s2_${s2_version}.tar.gz"  # current version
    sf_source_dl="https://cloud.r-project.org/src/contrib/sf_${sf_version}.tar.gz"

}


set_install_locations() {

    sqlite_install_dir="${BASE_INSTALL_DIR}"/sqlite
    geos_install_dir="${BASE_INSTALL_DIR}"/geos
    proj_install_dir="${BASE_INSTALL_DIR}"/proj
    gdal_install_dir="${BASE_INSTALL_DIR}"/gdal
    s2_install_dir="${BASE_INSTALL_DIR}"/Rpkgs
    sf_install_dir="${BASE_INSTALL_DIR}"/Rpkgs

}


install_sqlite() {
    
    echo ""
    msg_headline "Installing SQLite3..."
    echo ""

    # necessary modules
    module purge
    module load gcc/8.3.1

    # force clean install
    if [[ -d "${sqlite_install_dir}" ]]; then
	rm -rf "${sqlite_install_dir}"
    fi

    # install sqlite
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

    msg_headline "Setting variables for sqlite..."
    export PATH=${sqlite_install_dir}/bin:$PATH
    if [[ -v LD_LIBRARY_PATH ]]; then
	export LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH
    else
	export LD_LIBRARY_PATH=/usr/lib64
    fi

}


install_geos() {

    echo ""
    msg_headline "Installing GEOS..."
    echo ""

    # necessary modules
    module purge
    module load gcc/8.3.1 cmake/3.18.4

    # force clean install
    if [[ -d "${geos_install_dir}" ]]; then
	rm -rf "${geos_install_dir}"
    fi

    # install geos
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

    msg_headline "Setting variables for geos..."
    export PATH=${geos_install_dir}/bin:$PATH
    export PATH=${geos_install_dir}/include:$PATH
    export PATH=${geos_install_dir}/lib:$PATH
    if [[ -v LD_LIBRARY_PATH ]]; then
	export LD_LIBRARY_PATH=${geos_install_dir}/lib:$LD_LIBRARY_PATH
    else
	export LD_LIBRARY_PATH=${geos_install_dir}/lib
    fi
}


install_proj() {

    echo ""
    msg_headline "Installing PROJ..."
    echo ""

    # necessary modules
    module purge
    module load gcc/8.3.1

    # force clean install
    if [[ -d "${proj_install_dir}" ]]; then
	rm -rf "${proj_install_dir}"
    fi

    # install proj
    mkdir -p ${proj_install_dir}
    cd ${proj_install_dir}
    wget ${proj_source_dl}
    tar -xvf proj-${proj_version}.tar.gz
    cd proj-${proj_version}
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

    msg_headline "Setting variables for proj..."
    export LD_LIBRARY_PATH=${proj_install_dir}/lib:$LD_LIBRARY_PATH
    if [[ -v LIBRARY_PATH ]]; then
	export LIBRARY_PATH=${proj_install_dir}/lib:$LIBRARY_PATH
    else
	export LIBRARY_PATH=${proj_install_dir}/lib
    fi
    #export CPATH=${proj_install_dir}/include:$CPATH
    export PATH=${proj_install_dir}/bin:$PATH
    if [[ -v PKG_CONFIG_PATH ]]; then
	export PKG_CONFIG_PATH=${proj_install_dir}/lib/pkgconfig:$PKG_CONFIG_PATH
    else
	export PKG_CONFIG_PATH=${proj_install_dir}/lib/pkgconfig
    fi

}


install_gdal() {

    echo ""
    msg_headline "Installing GDAL..."
    echo ""

    # necessary modules
    module purge
    module load gcc/8.3.1

    # force clean install
    if [[ -d "${gdal_install_dir}" ]]; then
	rm -rf "${gdal_install_dir}"
    fi

    # install gdal
    mkdir -p ${gdal_install_dir}
    cd ${gdal_install_dir}
    git clone ${gdal_source_dl}
    cd gdal/gdal
    ./configure --prefix=${gdal_install_dir} --with-proj=${proj_install_dir} --with-sqlite3=${sqlite_install_dir} --with-geos=${geos_install_dir}/bin/geos-config
    make
    if [[ $? -ne 0 ]]; then die "GDAL installation failed."; fi
    make install
    if [[ $? -ne 0 ]]; then die "GDAL installation failed."; fi

    echo ""
    msg_complete "GDAL installation complete."
    echo ""

}


setvars_gdal() {
 
    msg_headline "Setting variables for gdal..."
    export PATH=${gdal_install_dir}/bin:$PATH
    export LD_LIBRARY_PATH=${gdal_install_dir}/lib:$LD_LIBRARY_PATH
    export GDAL_DATA=${gdal_install_dir}/share/gdal

}


install_s2() {

    echo ""
    msg_headline "Installing s2 in R..."
    echo ""

    # necessary modules
    module purge
    module use /gpfs/group/RISE/sw7/modules
    module load r/4.0.3

    # set makevars
    rmakevars_gcc
    
    # install sf
    export R_LIBS_USER=${s2_install_dir}
    mkdir -p ${s2_install_dir}
    cd ${s2_install_dir}
    wget ${s2_source_dl}
    R CMD INSTALL s2_${s2_version}.tar.gz --library=${s2_install_dir}
    if [[ $? -ne 0 ]]; then die "s2 installation failed."; fi
    rm ${s2_install_dir}/s2_${s2_version}.tar.gz
    
    rmakevars_revert

    echo ""
    msg_complete "s2 installation complete."
    echo ""
    
}


setvars_s2() {

    msg_headline "Setting variables for s2... None to set."

}


install_sf() {

    echo ""
    msg_headline "Installing sf in R..."
    echo ""

    # necessary modules
    module purge
    module use /gpfs/group/RISE/sw7/modules
    module load r/4.0.3

    # set makevars
    rmakevars_gcc

    # install sf
    export R_LIBS_USER=${sf_install_dir}
    mkdir -p ${sf_install_dir}
    cd ${sf_install_dir}
    wget ${sf_source_dl}
    R CMD INSTALL sf_${sf_version}.tar.gz --library=${sf_install_dir}
    if [[ $? -ne 0 ]]; then die "sf installation failed."; fi
    rm ${sf_install_dir}/sf_${sf_version}.tar.gz
    
    rmakevars_revert

    echo ""
    msg_complete "sf installation complete."
    echo ""
    
}


setvars_sf() {

    msg_headline "Setting variables for sf... None to set."

}


rmakevars_gcc() {

    msg_headline "Switching R compiler from intel to gcc..."

    # switch compiler to gcc
    rmakefiledir="/gpfs/group/RISE/sw7/R-4.0.3-intel-19.1.2-mkl-2020.3/install/lib64/R/etc"
    cd ${rmakefiledir}
    if [[ -f Makeconf ]]; then
	unlink Makeconf
    fi
    ln -s Makeconf_gcc Makeconf
    module unload intel/19.1.2
    module load gcc/8.3.1

}

rmakevars_revert() {

    # switch back to intel
    if [[ -f Makeconf ]]; then
	unlink Makeconf
    fi
    ln -s Makeconf_intel Makeconf

}


login_env_setup() {

    cd /storage/home/$(whoami)
    bashenvfile=".bash_env_sf"
    msg_headline "Setting variables in ~/${bashenvfile}..."
    touch ${bashenvfile}

    # place all setvars content in bashenvfile
    for j in "${PACKAGE_LIST_DEFAULT[@]}"; do
	echo `in_func setvars_${j}` >> ${bashenvfile}
    done

    # source bashenvfile in bashrc
    cat << EOF >> .bashrc

# environment setup for sf R package and its dependencies
# this was place here by the sf_installer script
if [ -e $HOME/${bashenvfile} ]; then
    source $HOME/${bashenvfile}
fi

EOF

}


in_func() {
    while [ "$1" ] ; do type $1 | sed  -n '/^    /{s/^    //p}' | sed '$s/.*/&;/' ; shift ; done ;
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

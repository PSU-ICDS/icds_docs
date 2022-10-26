#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - #
#
#    turbo_seti (PSU) Installer for Roar
#      --> ICDS i-Ask Center
#
#    source: 
#      --> https://github.com/Sofysicist/turbo_seti
#
#    ece5034
#
# - - - - - - - - - - - - - - - - - - - - - #


print_title() {
    printf "\n\nturbo_seti_installer.sh: This script installs turbo_seti on Roar.\n"
}


print_help() {
    printf "\nFor details on usage, run the following command:\n  $ bash turbo_seti_installer.sh -u\n\n\n"
}

#### UPDATE ####
print_usage() {
  printf "\nUsage:"
  printf "\n\n  Required Flags and Arguments:"
  printf "\n    -i  :  top install directory (argument: full path to desired install directory  [default = ${inloc_default}])"
  printf "\n    -n  :  prompt user for number of make threads (argument: integer  [default = ${n_default}])"
  printf "\n              *note: install job must have access to at least n+1 processors"
  printf "\n\n  Optional Flags:"
  printf "\n    -g  :  set GEANT4 version via user prompt  [default = ${geant4ver_default}]"
  printf "\n    -p  :  prompt user to proceed at checkpoints"
  printf "\n    -t  :  run test on install"
  printf "\n\n  Informational Flags:"
  printf "\n    -h  :  help"
  printf "\n    -u  :  usage"
  printf "\n\n\n  Example:  build GEANT4 ${geant4ver_default} in /gpfs/path2/install/dir with 4 make processes and prompts turned ON"
  printf "\n\n    $ bash geant4_installer.sh -i /gpfs/path2/install/dir/ -n 4 -p \n\n\n"
}
##############

headline() {
    statement=${1}
    echo -e "\n  --> ${statement} \n"
    "HEADLINE:  ${statement}" >> logfile
}


log() {
    statement=${1}
    echo -e ${statement}
    ${statement} >> logfile
}


error() {
    statement="ERROR:  ${1}"
    echo -e ${statement}
    ${statement} >> errorfile
    ${statement} >> logfile
}


userprompt() {
    # determine prompt_flag status inside function
    # $ userprompt prompt_flag "Question here"
    # return [ userinput ]
    # access returned value using $? in main body

    
}


showtime() {

    #start=`date +%s`
    #end=`date +%s`
    #runtime=$((end-start))

    num=$1
    min=0
    hour=0
    day=0

    if ((num>59)); then
        ((sec=num%60))
        ((num=num/60))
        if((num>59));then
            ((min=num%60))
            ((num=num/60))
            if((num>23));then
                ((hour=num%24))
                ((day=num/24))
            else
                ((hour=num))
            fi
        else
            ((min=num))
        fi
    else
        ((sec=num))
    fi
    echo -e "$day"d "$hour"h "$min"m "$sec"s
}




# - - - - - Set up environment - - - - - #
module purge
module load python gcc/5.3.1 hdf5

today=`date '+%Y%m%d'`
scratch="/gpfs/scratch/$(whoami)"

geant4ver_default='10.06'
geant4ver=''
inloc_default="${scratch}/sw"
inloc=''
n_default='1'
n=''
test_flag='false'
prompt_flag='false'
dl_flag='false'
dllink=''


# - - - - - - - - - - - - - - - - - - - - #


# - - - - - Grab inputs - - - - - #
while getopts "i:n:gpthu" opt; do
    case "${opt}" in
	# inputs
	i) inloc=${OPTARG} ;;
	n) n=${OPTARG} ;;
	# flags
	g) geant4ver_flag='true' ;;
	p) prompt_flag='true' ;;
	t) test_flag='true' ;;
	# informational
	h) print_title
	    print_help
	    exit 1 ;;
        u) print_title
	    print_usage
	    exit 1 ;;
	*) print_title
	    print_usage
	    exit 1 ;;
    esac
done

print_title
echo -e "\n  -->  Initiating pre-install checks ...\n"

# - - - - - - - - - - - - - - - - - - - - #


# - - - - - Check input validity - - - - - #

# set install directory to default if none set
if [[ -z "$inloc" ]]; then
    inloc="${inloc_default}"
    echo -e "No install location specified.  Using default install location: ${inloc}"
fi

# check install directory
if [[ ! -d "$inloc" ]]; then
    echo -e "Install directory is invalid."

    if [[ "$prompt_flag" = 'true' ]]; then
	echo
	userinput=""
	echo -e "The creation of this directory will be forced. Input 'stop' to quit, use any other input to proceed."
	read userinput
	if [[ "$userinput" = "stop" ]]; then
	    exit 1;
	else
	    echo -e "You chose to proceed, attempting to create ${inloc} ..."
	    mkdir -p ${inloc}
	    if [[ ! -d "$inloc" ]]; then
		echo -e "Failed to successfully create ${inloc} for installation."
		exit 1
	    fi
	fi
	echo
    else
	exit 1;
    fi
fi

# set GEANT4 version if geant4ver_flag set
if [[ "$geant4ver_flag" = 'true' ]]; then
    echo
    userinput=""
    echo -e "Please specify desired version of GEANT4. Enter 'stop' to cancel install."
    geant4ver_form='^[0-9]{1,2}\.[0-9]{1,2}$'
    read userinput
    if [[ "$userinput" = "stop" ]]; then
	exit 1
    elif [[ "$userinput" =~ $geant4ver_form ]]; then
	geant4ver="$userinput"
	echo -e "GEANT4 version ${geant4ver} specified ..."
    else
	echo -e "Invalid GEANT4 version entered!"
	exit 1
    fi
else
    geant4ver=${geant4ver_default}
fi

# set up build directory
builddir="${inloc}/geant4_${geant4ver}"
i=0
obuilddir="${builddir}"
while [[ -d "$builddir" ]]
do
    i=$((i+1))
    builddir="${obuilddir}_${i}"
done
mkdir -p "$builddir"

# check build directory existence
if [[ ! -d "$builddir" ]]; then
    echo -e "Invalid build directory!"
    exit 1
fi

# check for available GEANT4
if [[ -f ${inloc}/geant4.${geant4ver}.p02.tar.gz ]]; then

    echo -e "Using available GEANT4 ${geant4ver} source files from install location ..."

elif [[ ! -f ${inloc}/geant4.${geant4ver}.p02.tar.gz ]]; then
  
    dllink="http://cern.ch/geant4-data/releases/geant4.${geant4ver}.p02.tar.gz"
    curl -s --head "${dllink}" | head -n 1 | grep "HTTP/1.[01] [23].." > /dev/null
    if [[ "$?" != 0 ]]; then
	echo -e "GEANT4 version is invalid!"
	exit 1

	# use default version of GEANT4
	echo
	userinput=""
	echo -e "The default version (GEANT4 ${geant4ver_default}) will be used. Enter 'cancel' to cancel installation or provide any other input to proceed."
	read userinput
	if [[ "$userinput" = "cancel" ]]; then
	    exit 1;
	else
	    geant4ver=${geant4ver_default}
	fi
	echo

    else
	echo -e "GEANT4 version seems valid and is available for download from CERN ..."
	dl_flag='true'
    fi

else
    echo -e "Error while checking on GEANT4 version availability."
    exit 1
fi

# check number of make threads
n_form='^[0-9]+$'
if [[ -z "$n" ]]; then
    n=${n_default}
    echo -e "Number of make threads not set. Using default number of ${n_default} ..."
elif [[ "$n" =~ "$n_form" ]]; then
    n=${n_default}
    echo -e "Invalid number of make threads. Setting number of make threads to ${n} and continuing ..."
else
    echo -e "Number of make threads seems fine ..."
fi


# - - - - - - - - - - - - - - - - - - - - #


# - - - - - Output install parameters - - - - - #

echo -e "\n  -->  Install parameters have been set ...\n"
echo "- - - - - - - - - - - - - - - - - - - -"

echo "GEANT4 Install Directory --> ${inloc}"
echo "GEANT4 Version           --> ${geant4ver}"
echo "Build Directory          --> ${builddir}"
echo "Number of Make Threads   --> ${n}"

if [[ "$dl_flag" = 'true' ]]; then
    echo "  ! GEANT4 ${geant4ver} will be installed from download."
fi
if [[ "$prompt_flag" = 'true' ]]; then
    echo "  ! Prompts will be generated at Checkpoints."
fi
if [[ "$n" -gt 1 ]]; then
    echo "  ! Installation will use ${n} make threads. User must have access to at least ${n}+1 cores for this to work."
fi
if [[ "$test_flag" = 'true' ]]; then
    echo "  ! Test suite will be run to check install."
fi

echo -e " - - - - - - - - - - - - - - - - - - - -\n"

echo -e "Modules loaded:"
module list


# - - - - - - - - - - - - - - - - - - - - #


# Checkpoint
if [[ "$prompt_flag" = 'true' ]]; then
    echo
    userinput=""
    echo -e "Ready to continue by downloading files. Input 'stop' to quit, use any other input to proceed."
    read userinput
    if [[ "$userinput" = "stop" ]]; then
	exit 1;
    else
	echo -e "You chose to proceed, so pressing on with downloading install files ..."
    fi
    echo
fi


# - - - - - Download install files - - - - - #
cd ${inloc}

if [[ "$dl_flag" = 'true' ]]; then
    echo -e "\n  -->  Downloading GEANT4 ${geant4ver} from CERN ...\n"
    wget "$dllink"
    if [[ ! -f "geant4.${geant4ver}.p02.tar.gz" ]]; then
	echo -e "Error while downloading GEANT4 ${geant4ver} from CERN."
	exit 1
    fi
    echo -e "GEANT4 ${geant4ver} download complete ..."
elif [[ "$dl_flag" = 'false' ]]; then
    if [[ (-f "geant4*${geant4ver}*.tar.gz") && (! -f "geant4.${geant4ver}.p02.tar.gz") ]]; then
	cp geant4*${geant4ver}*.tar.gz geant4.${geant4ver}.p02.tar.gz
    fi
    echo -e "GEANT4 ${geant4ver} already is available in install location. No download necessary ..."
else
    echo -e "There was an issue setting up the download."
    exit 1
fi

if [[ -d "geant4.${geant4ver}.p02" ]]; then
    echo -e "geant4.${geant4ver}.p02.tar.gz has already been extracted ..."
elif [[ ! -d "geant4.${geant4ver}.p02" ]]; then
    echo -e "Extracting geant4.${geant4ver}.p02.tar.gz ..."
    tar -xzf geant4.${geant4ver}.p02.tar.gz
    echo -e "Extraction complete ..."
else
    echo -e "There was an issue extracting geant4.${geant4ver}.p02.tar.gz."
    exit 1
fi


# - - - - - - - - - - - - - - - - - - - - #


# - - - - - Install software - - - - - #

# Checkpoint
if [[ "$prompt_flag" = 'true' ]]; then
    echo
    userinput=""
    echo -e "Ready to continue by initializing GEANT4 ${geant4ver} install. Input 'stop' to quit, use any other input to proceed."
    read userinput
    if [[ "$userinput" = "stop" ]]; then
	exit 1;
    else
	echo -e "You chose to proceed, so pressing on with install initialization ..."
    fi
    echo
fi

# install GEANT4
echo -e "\n  -->  Installing GEANT4 ${geant4ver}...\n"
cd ${builddir}
mkdir X11_include && cd X11_include
wget https://repo.kaosx.us/main/libxmu-1.1.3-1-x86_64.pkg.tar.xz
tar -xf libxmu-1.1.3-1-x86_64.pkg.tar.xz
cd ${builddir}

cmake \
    -DCMAKE_INSTALL_PREFIX="${builddir}/" \
    -DGEANT4_INSTALL_DATA=ON \
    -DGEANT4_USE_OPENGL_X11=ON \
    -DX11_Xmu_INCLUDE_PATH=${builddir}/X11_include/usr/include/X11/Xmu/ \
    -DX11_Xmu_LIB=/usr/lib64/libXmu.so.6.2.0 \
    -DGEANT4_BUILD_MULTITHREADED=ON \
    -DGEANT4_USE_QT=ON \
    ${inloc}/geant4.${geant4ver}.p02

if [[ "$n" -gt 1 ]]; then
    make -j${n}
else
    make
fi

# Checkpoint
if [[ "$prompt_flag" = 'true' ]]; then
    echo
    userinput=""
    echo -e "Ready to continue by installing GEANT4 ${geant4ver}. Input 'stop' to quit, use any other input t\
o proceed."
    read userinput
    if [[ "$userinput" = "stop" ]]; then
        exit 1;
    else
        echo -e "You chose to proceed, so pressing on with installing GEANT4 ..."
    fi
    echo
fi

make install
echo -e "\n  -->  GEANT4 ${geant4ver} installation done ...\n"

source "${builddir}/bin/geant4.sh"
echo -e "${builddir}/bin/geant4.sh has been sourced ..."


# - - - - - - - - - - - - - - - - - - - - #


# - - - - - Check installs if test mode activated - - - - - #

if [[ "$test_flag" = 'true' ]]; then
    
    # Checkpoint
    if [[ "$prompt_flag" = 'true' ]]; then
	echo
	userinput=""
	echo -e "Ready to continue by testing the install. Input 'stop' to quit, use any other input to proceed."
	read userinput
	if [[ "$userinput" = "stop" ]]; then
	    exit 1;
	else
	    echo -e "You chose to proceed, so pressing on with testing the install ..."
	fi
	echo
    fi

    echo -e "GEANT4 ${geant4ver} test suite not yet available ..."
    #echo -e "\n  -->  Running tests on GEANT4 ${geant4ver} install ...\n"
    # !!!!!! INSERT TEST PROCEDURE HERE !!!!!!!!!!
    #echo -e "\n  -->  GEANT4 ${geant4ver} testing complete ...\n"
fi


# - - - - - - - - - - - - - - - - - - - - #


# - - - - Clean up - - - - - #
# no cleanup necessary
# - - - - - - - - - - - - - - - - - - - - #


echo -e "\n  -->  geant4_installer.sh is done ...\n"
echo "- - - - - - - - - - - - - - - - - - - -"
echo "GEANT4 Install Directory --> ${inloc}"
echo "GEANT4 Version           --> ${geant4ver}"
echo "Build Directory          --> ${builddir}"
echo -e " - - - - - - - - - - - - - - - - - - - -\n"


# 2020/10
# Emery Etter
#  --> emery@psu.edu

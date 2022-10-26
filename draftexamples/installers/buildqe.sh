#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - #
#
#    Quantum Espresso Installer for ACI
#      --> ICDS i-Ask Center
#
# - - - - - - - - - - - - - - - - - - - - - #


print_title() {
    printf "\n\nbuildqe.sh: This script installs the specified Quantum Espresso version (from either a source directory or the QE Github page) in the desired install directory on ACI.\n"
}


print_help() {
    printf "\nFor details on usage, run the following command:\n  $ bash buildqe.sh -u\n\n\n"
}


print_usage() {
  printf "\nUsage:"
  printf "\n\n  Required Flags and Arguments:"
  printf "\n    -i  :  top install directory  (argument: full path to desired install directory)"
  printf "\n    -q  :  QE version             (argument: valid version  [default = ${qever_default}])"
  printf "\n    -s  :  source file directory  (argument: full path to QE build source files  OR  download)"
  printf "\n\n  Optional Flags:"
  printf "\n    -e  :  set ELPA version via user prompt  [default = ${elpaver_default}]"
  printf "\n    -h  :  help"
  printf "\n    -p  :  prompt user to proceed at checkpoints"
  printf "\n    -t  :  run test on install"
  printf "\n    -u  :  usage"
  printf "\n\n\n  Example:  build QE 6.4.1 from source with prompts and testing turned ON"
  printf "\n\n    $ bash buildqe.sh -i /path2/install/dir/ -s /path2/source/dir/ -q 6.4.1 -pt \n\n\n"
}


# - - - - - Set up environment - - - - - #
module use /gpfs/group/dml129/default/sw/modules
module load intel/2018
today=`date '+%Y%m%d'`
work="/storage/work/$(whoami)"
installdir_default="${work}/sw"
installdir=""
sourcedir=""
elpaver_default="2019.11.001"
elpaver="$elpaver_default"
elpaver_flag='false'
qever_default="6.4.1"
qever=""
test_flag='false'
prompt_flag='false'
dl_flag='false'


# - - - - - - - - - - - - - - - - - - - - #


# - - - - - Grab inputs - - - - - #
while getopts "i:q:s:epthu" opt; do
    case "${opt}" in
        i) installdir=${OPTARG} ;;
	q) qever=${OPTARG} ;;
        s) sourcedir=${OPTARG} ;;
	e) elpaver_flag='true' ;;
	p) prompt_flag='true' ;;
	t) test_flag='true' ;;
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
echo -e "\n  -->  Initiating pre-install checks...\n"

# - - - - - - - - - - - - - - - - - - - - #


# - - - - - Check input validity - - - - - #

# check whether installing from specified source directory or from QE download
if [[ "$sourcedir" = "download" && -z "$qever" ]]; then
    echo -e "Please specify a version of QE to download and try again."
elif [[ "$sourcedir" = "download" ]]; then
    dl_flag='true'
    echo -e "QE Installer will attempt to download qe_${qever} from the QE Github repo."
elif [[ -d "$sourcedir" ]]; then
    echo -e "Source directory found."
elif [[ ! -d "$sourcedir" ]]; then
    echo -e "Invalid source directory!"
    exit 1
else
    echo -e "Unknown error when checking sourcedir validity..."
    exit 1
fi

# set QE install directory to default if none set
if [[ -z "$installdir" ]]; then
    installdir="${installdir_default}"
fi

qebase="${installdir}/qe_${qever}_${today}"
i=0
oqebase="${qebase}"
while [[ -d "$qebase" ]]
do
    i=$((i+1))
    qebase="${oqebase}_${i}"
done
mkdir -p "$qebase"

# check install directory existence
if [[ ! -d "$qebase" ]]; then
    echo -e "Invalid QE install directory!"
    exit 1
fi

# set ELPA version if elpaver_flag set
if [[ "$elpaver_flag" = 'true' ]]; then
    echo
    userinput=""
    echo -e "Please specify desired version of ELPA. Enter 'stop' to cancel install."
    elpaver_form='^[0-9][0-9][0-9][0-9]\.[0-9][0-9]\.[0-9][0-9][0-9]$'
    read userinput
    if [[ "$userinput" = "stop" ]]; then
	exit 1
    elif [[ "$userinput" =~ $elpaver_form ]]; then
	elpaver="$userinput"
	echo -e "ELPA version ${elpaver} specified, checking now..."
    else
	echo -e "Invalid ELPA version entered."
	exit 1
    fi
fi

# check for available ELPA
if [[ -f "$installdir"/elpa-${elpaver}.tar.gz ]]; then

    cp "$installdir"/elpa-${elpaver}.tar.gz "$qebase"
    echo -e "ELPA available in ${installdir}/elpa-${elpaver}.tar.gz ... copying now..."

elif [[ ! -f "$installdir"/.tar.gz ]]; then
    
    curl -s --head https://elpa.mpcdf.mpg.de/html/Releases/${elpaver}/elpa-${elpaver}.tar.gz | head -n 1 | grep "HTTP/1.[01] [23].." > /dev/null
    if [[ "$?" != 0 ]]; then
	echo -e "ELPA version is invalid!"
	exit 1
    else
	echo -e "ELPA version seems valid."
    fi

else
    echo -e "Error while checking on EPLA version availability."
    exit 1
fi


# check QE version for valid download address
if [[ "$dl_flag" = "true" ]]; then
    curl -s --head https://gitlab.com/QEF/q-e/-/archive/qe-${qever}/q-e-qe-${qever}.tar.gz | head -n 1 | grep "HTTP/1.[01] [23].." > /dev/null
    if [[ "$?" != 0 ]]; then
	echo -e "QE version is invalid!"
	
	# use default version of qe
	echo
	userinput=""
	echo -e "The default version of qe_${qever_default} will be used. Enter 'cancel' to cancel installation or provide any other input to proceed."
	read userinput
	if [[ "$userinput" = "cancel" ]]; then
	    exit 1;
	else
	    qever=${qever_default}
	fi
	echo

    else
	echo -e "QE version seems valid."
    fi
fi


# - - - - - - - - - - - - - - - - - - - - #


# - - - - - Output install parameters - - - - - #

echo -e "\n  -->  Install parameters have been set...\n"
echo "- - - - - - - - - - - - - - - - - - - -"
echo "QE Install Directory --> ${qebase}"
echo "QE Source Directory  --> ${sourcedir}"
echo "ELPA Version         --> ${elpaver}"
echo "QE Version           --> ${qever}"
if [[ "$dl_flag" = 'true' ]]; then
    echo "  ! QE will be installed from download."
fi
if [[ "$prompt_flag" = 'true' ]]; then
    echo "  ! Prompts will be generated at Checkpoints."
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
	echo -e "You chose to proceed, so pressing on with downloading install files."
    fi
    echo
fi


# - - - - - Download install files - - - - - #

echo -e "\n  -->  Downloading any necessary files...\n"

cd ${qebase}

# download and extract ELPA
if [[ ! -f elpa-${elpaver}.tar.gz ]]; then
    echo -e "Downloading ELPA..."
    wget https://elpa.mpcdf.mpg.de/html/Releases/${elpaver}/elpa-${elpaver}.tar.gz
fi
if [[ -f elpa-${elpaver}.tar.gz ]]; then
    elpainstalldir="${qebase}/elpa-${elpaver}"
    tar -xzf elpa-${elpaver}.tar.gz
    echo -e "ELPA download complete."
else
    echo -e "An error occurred downloading ELPA."
    exit 1
fi
echo -e "ELPA install directory --> $elpainstalldir"

# download and extract QE download if installing from download
if [[ "$dl_flag" = 'true' ]]; then
    wget https://gitlab.com/QEF/q-e/-/archive/qe-${qever}/q-e-qe-${qever}.tar.gz
    if [[ -f q-e-qe-${qever}.tar.gz ]]; then
	tar -xzf q-e-qe-${qever}.tar.gz
    else
	echo -e "An error occurred downloading QE."
	exit 1
    fi
    sourcedir="${qebase}/*qe*${ver}"
    echo -e "QE source directory --> $sourcedir"
    echo -e "QE download complete."
fi


# - - - - - - - - - - - - - - - - - - - - #


# - - - - - Install software - - - - - #

# Checkpoint
if [[ "$prompt_flag" = 'true' ]]; then
    echo
    userinput=""
    echo -e "Ready to continue by installing ELPA. Input 'stop' to quit, use any other input to proceed."
    read userinput
    if [[ "$userinput" = "stop" ]]; then
	exit 1;
    else
	echo -e "You chose to proceed, so pressing on with installing ELPA."
    fi
    echo
fi

echo -e "\n  -->  Installing ELPA...\n"

# install EPLA
cd ${elpainstalldir}
wget --no-check-certificate https://github.com/hfp/xconfigure/raw/master/configure-get.sh
chmod +x configure-get.sh
./configure-get.sh elpa
make clean
wget --no-check-certificate https://raw.githubusercontent.com/hfp/xconfigure/master/config/elpa/configure-elpa-snb-omp.sh
chmod +x configure-elpa-snb-omp.sh
./configure-elpa-snb-omp.sh
make
make install
echo -e "\n  -->  ELPA installation done...\n"


# Checkpoint
if [[ "$prompt_flag" = 'true' ]]; then
    echo
    userinput=""
    echo -e "Ready to continue by installing QE. Input 'stop' to quit, use any other input to proceed."
    read userinput
    if [[ "$userinput" = "stop" ]]; then
	exit 1;
    else
	echo -e "You chose to proceed, so pressing on with installing QE."
    fi
    echo
fi

echo -e "\n  -->  Installing QE ${qever} ...\n"

# install QE
cd ${qebase}
mkdir qe-${qever}
cd qe-${qever}
cp -a ${sourcedir}/. .
wget --no-check-certificate https://github.com/hfp/xconfigure/raw/master/configure-get.sh
chmod +x ./configure-get.sh
./configure-get.sh qe
wget --no-check-certificate https://raw.githubusercontent.com/hfp/xconfigure/master/config/qe/configure-qe-snb-omp.sh
chmod +x ./configure-qe-snb-omp.sh
./configure-qe-snb-omp.sh
make all
echo -e "\n  -->  QE installation done...\n"


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
	    echo -e "You chose to proceed, so pressing on with testing the install."
	fi
	echo
    fi

    echo -e "\n  -->  Running built-in QE ${qever} tests ...\n"
    cd "$qebase"/qe-${qever}/test-suite
    make run-tests
    echo -e "\n  -->  QE ${qever} testing complete...\n"
fi


# - - - - - - - - - - - - - - - - - - - - #


# - - - - Clean up - - - - - #
# no cleanup necessary
# - - - - - - - - - - - - - - - - - - - - #


echo -e "\n  -->  buildqe.sh is done...\n"


# 2020/09
# Emery Etter

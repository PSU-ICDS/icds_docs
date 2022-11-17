#!/bin/bash

# - - - - Load necessary modules - - - -
module purge
module load python gcc/5.3.1 hdf5

# - - - - Set up turbo_seti install dir - - - -
work="/storage/work/$(whoami)"
inbase_ts="${work}/sw"
if [[ -d "${inbase_ts}" ]]; then
    echo -e "  -->  turbo_seti to be installed here:  ${inbase_ts}"
elif [[ ! -d "${inbase_ts}" ]]; then
    mkdir -p ${inbase_ts}
    if [[ -d "${inbase_ts}" ]]; then
	echo -e " ${inbase_ts} -->  turbo_seti to be installed here:  ${inbase_ts}"
    elif [[ ! -d "${inbase_ts}" ]]; then
	echo -e "  !!!! turbo_seti install directory was not able to be created!"
	exit 1;
    fi
else
    echo -e "  !!!! something went wrong while setting up the turbo_seti install location!"
    exit 1;
fi


# - - - - Set up dir for local pip installs - - - -
cd ${work}
inbase_pip="${work}/.tseti_local"
if [[ -d "${inbase_pip}" ]]; then
    echo -e "  -->  turbo_seti pip packages to be installed here:  ${inbase_pip}"
elif [[ ! -d "${inbase_pip}" ]]; then
    mkdir -p ${inbase_pip}
    if [[ -d "${inbase_pip}" ]]; then
	echo -e " ${inbase_pip} -->  turbo_seti pip packages to be installed here:  ${inbase_pip}"
    elif [[ ! -d "${inbase_pip}" ]]; then
	echo -e "  !!!! pip install directory was not able to be created!"
	exit 1;
    fi
else
    echo -e "  !!!! something went wrong while setting up the pip install location!"
    exit 1;
fi
export PATH="${inbase_pip}/bin:${PATH}"


# - - - - Collect turbo_seti files - - - -
cd ${inbase_ts}
mkdir psu_turbo_seti
cd psu_turbo_seti
git init
git pull https://github.com/Sofysicist/turbo_seti.git

# - - - - Install dependencies - - - -
#pip install --upgrade setuptools wheel --ignore-installed --install-option="--prefix=${inbase_pip}"
#pip install --only-binary=numpy,scipy numpy scipy --ignore-installed --install-option="--prefix=${inbase_pip}"
#pip install numpy==1.16.0 --ignore-installed --install-option="--prefix=${inbase_pip}"
#pip install scipy --ignore-installed --install-option="--prefix=${inbase_pip}"
#pip install cython --ignore-installed --install-option="--prefix=${inbase_pip}"
#pip install six --ignore-installed --install-option="--prefix=${inbase_pip}"
#pip install h5py --only-binary=h5py --global-option="-I/opt/aci/sw/hdf5/1.8.18_gcc-5.3.1/include" --global-option="-L/opt/aci/sw/hdf5/1.8.18_gcc-5.3.1/lib64" --ignore-installed --install-option="--prefix=${inbase_pip}"
#pip install h5py --global-option="-I/opt/aci/sw/hdf5/1.8.18_gcc-5.3.1/include" --global-option="-L/opt/aci/sw/hdf5/1.8.18_gcc-5.3.1/lib64" --ignore-installed --install-option="--prefix=${inbase_pip}"
#pip install h5py --global-option="-I/opt/aci/sw/hdf5/1.8.18_gcc-5.3.1/include" --global-option="-L/opt/aci/sw/hdf5/1.8.18_gcc-5.3.1/lib64" --install-option="--prefix=${inbase_pip}"
#pip install h5py --global-option="-I/opt/aci/sw/hdf5/1.8.18_gcc-5.3.1/include" --global-option="-L/opt/aci/sw/hdf5/1.8.18_gcc-5.3.1/lib64" --ignore-installed --no-deps --install-option="--prefix=${inbase_pip}"


pip install numpy==1.16.0 --only-binary=numpy --ignore-installed --install-option="--prefix=${inbase_pip}"
pip install scipy --only-binary=scipy --ignore-installed --install-option="--prefix=${inbase_pip}"
pip install cython --ignore-installed --install-option="--prefix=${inbase_pip}"
pip install six --only-binary=six --ignore-installed --install-option="--prefix=${inbase_pip}"
export NPY_NO_DEPRECATED_API
pip install h5py --only-binary=h5py --ignore-installed --no-deps --install-option="--prefix=${inbase_pip}"
pip install -r requirements.txt --ignore-installed --install-option="--prefix=${inbase_pip}"
pip install -r requirements_test.txt --ignore-installed --install-option="--prefix=${inbase_pip}"
pip install . --ignore-installed --install-option="--prefix=${inbase_pip}"


# - - - - Run python importer to check all versions - - - -
echo -e "  -->  now checking versions of all necessary packages..."
python - <<EOF

print("importing packages...\n")
import sys
import numpy
import scipy
import cython
import h5py
import turbo_seti

print("- - - - - - - - - VERSION INFO: - - - - - - - - ")
print("python:      " + str(sys.version))
print("numpy:       " + str(numpy.__version__))
print("scipy:       " + str(scipy.__version__))
print("cython:      " + str(cython.__version__))
print("h5py:        " + str(h5py.__version__))
print("turbo_seti:  " + str(turbo_seti.__version__))
print("- - - - - - - - - - - - - - - - - - - - - - - - ")

EOF

echo -e "  -->  roar_turbo_seti_installer complete."

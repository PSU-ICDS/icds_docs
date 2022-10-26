# Table of Contents

* [Overview](#overview)
* [Installation](#installation)
* [Accessing Documentation](#accessing-documentation)
* [Bug Reporting and Requesting Features](#bug-reporting-and-requesting-features)
* [Contributing Guidelines](#contributing-guidelines)
* [License](#license)
* [Troubleshooting](#troubleshooting)

# Overview

Welcome to the **iaskutils** GitHub repository!

![Demonstration](./share/gifs/demo.gif)

You might be asking yourself, "what is a iaskutils collection?" Well, it is just a collection of various scripts and tools used by the [Penn State ICDS i-ASK helpdesk](https://www.icds.psu.edu/computing-services/support/) to help the users of the Roar supercomputer. The iaskutils collection is ever growing, but here is a list of the tools currently available in the collection:

* **`collector`:** A simple script to collect information about your environment.
* **`gathero`:** A script to collect essential information about a user's job(s).
* **`relinkworkscratch`:** A simple script to reestablish the work and scratch directory symlinks in a user's home directory.
* **`setupcomsolsymlink`:** A simple script to relocate the COMSOL cache to the work directory.
* **`setupcondasymlink`:** A simple script to relocate the conda cache to the work directory.
* **`updatekeys`:** Create a new ssh-key that will allow you to log onto the compute nodes without entering a password.

To get access to the collection on the Roar cluster, you simply just need to use the following commands:

```bash
$ module use /gpfs/group/dml129/default/sw7/modules
$ module load iaskutils/1.4.1
```

Now let's get onto the meat of this README!

# Installation

1. [Installing Python](#installing-python)
2. [Set up the iaskutils module file](#set-up-the-iaskutils-module-file)
3. [Installing the dependencies](#installing-the-dependencies)
4. [Install the iaskutils](#install-the-iaskutils)
5. [Cleaning up](#cleaning-up)

## Installing Python

First, in order to use the **iaskutils** collection, you need to install a publicly accessible Python interpreter on Roar for iaskutils. Use the following commands to compile and install the iaskutils custom Python interpeter:

```bash
$ module load gcc/8.3.1
$ cd /gpfs/group/dml129/default/sw7
$ wget https://www.python.org/ftp/python/3.9.4/Python-3.9.4.tar.xz -O - | tar -xJv
$ export INSTALL_ROOT=$(pwd)
$ cd Python-3.9.4
$ ./configure --enable-shared --enable-optimizations --prefix=$INSTALL_ROOT/python-3.9.4
$ make && make install
$ chmod -R ugo+rx $INSTALL_ROOT/python-3.9.4 
```

Now that the iaskutil's custom Python interpreter is ready to go, we need to set up the iaskutils module file before compiling the tools in the collection!

## Set up the iaskutils module file

Now, in order for users and i-ASK teamates alike to access the iaskutils collection on Roar, you need to set up the corresponding module file. Luckily, you only need to use the following commands to set up the module file:

```bash
$ cd /gpfs/group/dml129/default/sw7
$ git clone https://github.com/ICDS-Roar/iaskutils.git
$ mkdir -p modules/iaskutils
$ cp iaskutils/share/modules/1.4.1.lua modules/iaskutils/1.4.1.lua
$ chmod -R ugo+rx modules
```

Once you have the iaskutils module file setup, it's time to start installing the various scripts in the collection! First, you will need to load the new iaskutils module by using the following commands:

```bash
$ module use /gpfs/group/dml129/default/sw7/modules
$ module load iaskutils/1.4.1
```

Now it is time to install the dependencies for iaskutils!

## Installing the dependencies

Use the following commands to install iaskutil's dependencies. *Just make sure that you have the iaskutils module loaded first*:

```bash
$ cd /gpfs/group/dml129/default/sw7/iaskutils
$ python3 -m pip install -r requirements.txt
$ python3 -m pip install nuitka
```
Once you have successfully installed the python modules listed in `requirements.txt` and the nuitka compiler, it is time to start installing the collection!

## Install the iaskutils

As of iaskutils release 1.4.1, you can now use GNU make to install the iaskutils collection! Automation at it's finest! All you need to do is use the following commands to successfully install the iaskutils collection:

```bash
$ module load gcc/8.3.1
$ module use /gpfs/group/dml129/default/sw7/modules
$ module load iaskutils/1.4.1
$ make all
$ make install
```

It's that simple!

### Installation notes

For testing purposes, you can execute `make test` before executing `make install` to verify that the iaskutils collection is functioning correectly. **Also**, you can build each iaskutil independantly in order to test the functionality of each utility. For example, here is how you would build `collector` individually:

```bash
$ make collector
```

Lastly, by default, the Makefile will use the python installed in `/gpfs/group/dml129/default/sw7/python-3.9.4/bin`. You can change this default by passing the following variable when calling make:

```bash
$ make all PYTHON_PATH=/some/path/to/a/python/interpreter/bin
```

## Cleaning up

It is a good idea that you save space after installing the iaskutils collection. To finish up the the installation, simply use the following commands

```bash
$ make clean
$ cd ..
$ chmod -R ugo+rx iaskutils
```

**Congratulations!** You have succesfully installed the iaskutils collection!

# Accessing Documentation

The nice thing about the iaskutils collection is that each of the scripts/tools included has a corresponding man page to go with it! For example, here is how you would retrieve the man page for **gathero**:

```bash
$ module use /gpfs/group/dml129/default/sw7/modules
$ module load iaskutils/1.4.1
$ man gathero
```

If man pages are not your style, you can access the PDF documentation for each of the scripts in the `/share/doc` directory of this repository.

# Bug Reporting and Requesting Features

* [Reporting Bugs](#reporting-bugs)
* [Requesting Features](#requesting-features)

## Reporting Bugs

If you encounter any bugs or any *oddities* when working with the iaskutils collection, please open an issue on this repository. In that issue, please include the following sections:

1. Which script are you using?
2. What are you trying to accomplish?
3. The stacktrace of the error you are receiving.

The more information the better. We cannot fix the problem if we do not know how it is being caused. Also, when you open the issue, please label the issue as a **bug**.

## Requesting Features

If there is a new tool or feature you would like to see added to this collection, please open an issue on this repository. While we cannot promise that every feature requested will be added, we will at least give it a look! Also, when requesting a feature as an issue, please label the issue as a **feature request** or **enhancement**.

# Contributing Guidelines

If you would like to help us add to the iaskutils collection by either fixing issues, adding new tools, or even porting to another cluster, please create a fork of this repository. In that fork, create a branch that alludes to what you are trying to accomplish.

After completing the work in your branch, please open a pull request to the main repository. In your pull request, please include the following things:

1. What did you add/modify in your branch?
2. Why did you make the addition/modification?

Once again, the more information you include the better! Once we review the pull request, we will determine if it should be merged or not! If we say no, we will comment why.

# License

![License](https://img.shields.io/badge/license-MIT-brightgreen)

This repository is licensed under the permisive MIT License. For more information on what this license entails, please feel free to visit https://en.wikipedia.org/wiki/MIT_License.

# Troubleshooting

If you encounter any issues while using any of the scripts contained in the iaskutils collection on the Roar cluster then please open an issue, or contact Jason at the ICDS i-ASK center at either iask@ics.psu.edu or jcn23@psu.edu.

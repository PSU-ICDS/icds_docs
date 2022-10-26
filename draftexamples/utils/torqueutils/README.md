# Table of Contents

* [Overview](#overview)
* [Installation](#installation)
* [Accessing Documentation](#accessing-documentation)
* [Bug Reporting and Requesting Features](#bug-reporting-and-requesting-features)
* [License](#license)
* [Troubleshooting](#troubleshooting)

# Overview
Welcome to my repository torqueutils! This repository just contains a collection of code that is used by the [ICDS i-ASK center](https://www.icds.psu.edu/) on torque to retrieve information about users jobs on the Roar supercomputer. The tools have various usages, so I will describe them below:

* **getusersjobids:** Retrieve users job ids for processing and analyzation.
* **getjobinfo:** Query information about a job or multiple jobs.

# Installation

1. [Environment setup](#environment-setup)
2. [Installing getusersjobids](#installing-getusersjobids)
3. [Installing getjobinfo](#installing-getjobinfo)

## Environment Setup

First, in order to install the **torqueutils** collection on the torque system, we need to set up the environment! While logged onto the Roar system, simply enter the following commands to get a python interpreter up and running:

```bash
$ module load anaconda3/2020.07
$ conda create --prefix /storage/work/dml129/sw7/python python=3.9
$ ssh torque01.util.production.int.aci.ics.psu.edu
$ export PATH=/storage/work/dml129/sw7/python/bin:$PATH
$ cd /storage/work/dml129/sw7
$ git clone https://github.com/ICDS-Roar/torqueutils.git
$ cd torqueutils
$ pip install -r requirements.txt
$ pip install pyinstaller
```

Now that we have the environment setup, we are now going to set up **getusersjobids** and **getjobinfo** using pyinstaller!

## Installing getusersjobids

Now, using pyinstaller, it is time to set up **getusersjobids**! Simply use the following commands:

```bash
$ pyinstaller getusersjobids.py
$ cd /storage/work/dml129
$ ln -s /storage/work/dml129/sw7/torqueutils/dist/getusersjobids/getusersjobids /storage/work/dml129/getusersjobids
```

If all goes well, you should be able to successfully run **getusersjobids** in your terminal:

```
$ ./getusersjobids --help
usage: getusersjobids [-h] [-u USER] [-d DAYS] [--xml] [--json] [--yaml] [--csv] [--table]
                      [-V] [--license]

optional arguments:
  -h, --help            show this help message and exit
  -u USER, --user USER  User to query (example: jcn23).
  -d DAYS, --days DAYS  Specify the number of days to check in the torque job logs (default:
                        5).
  --xml                 Print job ids in XML format.
  --json                Print job ids in JSON format.
  --yaml                Print job ids in YAML format.
  --csv                 Print job ids in CSV format.
  --table               Print job ids in tabular format.
  -V, --version         Print version info.
  --license             Print licensing info.
```

Congratulations! If you received the above output, you have successfully installed **getusersjobids**! Now onto installing **getjobinfo**!

## Installing getjobinfo

Like **getusersjobids**, **getjobinfo** is just as easy to set up! Simply use the following commands:

```bash
$ pyinstaller getjobinfo.py
$ cd /storage/work/dml129
$ ln -s /storage/work/dml129/sw7/torqueutils/dist/getjobinfo/getjobinfo /storage/work/dml129/getjobinfo
```

If all goes well, you should be able to successfully run **getjobinfo** in your terminal:

```
$ ./getjobinfo --help
usage: getjobinfo [-h] [-f FILE] [-d DAYS] [--xml] [--json] [--yaml] [--table] [-V]
                  [--license]
                  [jobid [jobid ...]]

positional arguments:
  jobid

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  Read job ids to query from an XML file instead.
  -d DAYS, --days DAYS  Specify the number of days to check in the torque job logs (default:
                        5).
  --xml                 Print job info in XML format.
  --json                Print job info in JSON format.
  --yaml                Print job info in YAML format.
  --table               Print job info in tabular format.
  -V, --version         Print version info.
  --license             Print licensing info.
```

Congratulations! You have successfully installed the torqueutils collection!

# Accessing Documentation

In order to access the documentation for the torqueutils collection, you have two options. You can either access the PDF documentation located in the `share/doc` directory, or you can read the man pages located in the `share/man/man1` directory. You can use the following commands in your terminal to open the man pages:

```bash
$ man share/man/man1/getusersjobids.1
$ man share/man/man1/getjobinfo.1
```

To read the PDF documentation, you can simply open the PDFs in any common PDF veiwer. 

# Bug Reporting and Requesting Features

* [Reporting Bugs](#reporting-bugs)
* [Requesting Features](#requesting-features)

## Reporting Bugs
If you encounter any bugs or any *oddities* when working with the torqueutils collection, please open an issue on this repository. In that issue, please include the following sections:

1. Which tool are you using?
2. What are you trying to accomplish?
3. The stacktrace of the error you are receiving.

The more information the better. I cannot fix the problem if I do not know how it is being caused. Also, when you open the issue, please label the issue as a **bug**.

## Requesting Features
If there is a new tool or feature you would like to see added to this collection, please open an issue on this repository. While I cannot promise that every feature requested will be added, I will at least give it a look! Also, when requesting a feature as an issue, please label the issue as a **feature request**.

# Contributing Guidelines
If you would like to help me add to the torqueutils collection by either fixing issues, adding new tools, or even porting to another cluster, please create a fork of this repository. In that fork, create a branch that alludes to what you are trying to accomplish.

After completing the work in your branch, please open a pull request to the main repository. In your pull request, please include the following things:

1. What did you add/modify in your branch?
2. Why did you make the addition/modification?

Once again, the more information you include the better! Once I review the pull request, I will determine if it should be merged or not! If I say no, I will comment why.

# License

![License](https://img.shields.io/badge/license-MIT-brightgreen)

This repository is licensed under the permisive MIT License. For more information on what this license entails, please feel free to visit https://en.wikipedia.org/wiki/MIT_License.


# Troubleshooting
If you encounter any issues while using this utility on the Roar cluster then please open an issue, or contact Jason at the ICDS i-ASK center at either iask@ics.psu.edu or jcn23@psu.edu.

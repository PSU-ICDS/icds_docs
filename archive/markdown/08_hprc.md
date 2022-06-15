---
title: Running Jobs on HPRC
---

HPRC jobs are submitted from the head nodes of ACI-b and will run when available resources are available on the compute nodes. Roar uses Moab and Torque for the scheduler and resource manager. Jobs can be either run in batch or interactive modes. Both are submitted using the qsub command.

  

#### 8.1 Requesting Resources

Whether you are submitting batch or interactive jobs, you are required to provide a list of requested resources to the scheduler. These are given either in the submission script or on the command line. If these are given in a submission script, they must come before any non-PBS command. Current limits on HPRC resource requests:  
• Pmem < 8GB  
• Mem < 160GB  
• Core/node <= 20  
• Node = 1

  

#### 8.1.1 Sample HPRC Batch Submission Script

The following is a submission script for a Matlab job that will run for 5 minutes on one processor. Note that an allocation is required to submit jobs to HPRC. Users familiar with submitting jobs to ACI-b will note only minor differences in this script.  
```
#!/bin/bash  
#PBS -l nodes=1:ppn=1  
#PBS -l walltime=5:00  
#PBS -q hprc
#PBS -A ics-hprc  

# Get started  
echo "Job started on ‘hostname‘ at ‘date‘"  

# Load in matlab  
module purge  
module load matlab  

# Go to the correct place  
cd $PBS_O_WORKDIR  

# Run the job itself - a matlab script called runThis.m  
matlab-bin -nodisplay -nosplash < runThis.m > log.matlabRun  

# Finish up  
echo "Job Ended at ‘date‘"
```

  

#### 8.2 Interactive Compute Sessions on HPRC

Interactive jobs may be submitted to HPRC using the -I (for interactive) flag. Interactive jobs require resource requests and an allocation. An interactive job can be submitted using a command similar to:

`qsub -I -A ics-hprc -q hprc -l nodes=1:ppn=20 -l mem=32gb -l walltime=1:23:30:00`

The job will be given a job ID, and your session will wait until this job has the resources to start. You will then be placed on the compute node and given a usable terminal session within your current session. For example, a user submitting an interactive job may see:

`[abc123@aci-lgn-008 abc123]$ qsub -I -A ics-hprc -q hprc -l nodes=1:ppn=20 -l mem=32gb -l walltime=1:23:30:00  
qsub: waiting for job 12907285.torque01.util.production.int.aci.ics.psu.edu to start  
qsub: job 12907285.torque01.util.production.int.aci.ics.psu.edu ready  
[abc123@comp-vc-1645 abc123]

To enable X11 forwarding to the interactive job, include the -x flag (output will be identical to above):

`qsub -I -x -A ics-hprc -q hprc -l nodes=1:ppn=20 -l mem=32gb -l walltime=1:23:30:00`

  

#### 8.3 Requesting a Custom Singularity Container on HPRC

Jobs on HPRC are run in an enterprise Linux 6 container. If you want your job to run in a custom Singularity container, you can specify that container either on the qsub command line or within your script.

Here is an example on the qsub command line:

`qsub -I -v SINGULARITY_CONTAINER="/storage/work/abc123/singularity/bionic-base.simg"`

For example, the above interactive job would provide:

`[abc123@aci-lgn-008 abc123]$ qsub -I -A ics-hprc -q hprc -l nodes=1:ppn=20 -l mem=32gb -l walltime=1:23:30:00  
qsub: waiting for job 12907285.torque01.util.production.int.aci.ics.psu.edu to start  
qsub: job 12907285.torque01.util.production.int.aci.ics.psu.edu ready  
[abc123@comp-vc-1645 abc123]$ cat /etc/os-release  
NAME="Ubuntu"  
VERSION="18.04.1 LTS (Bionic Beaver)"  
ID=ubuntu  
ID_LIKE=debian  
PRETTY_NAME="Ubuntu 18.04.1 LTS"  
VERSION_ID="18.04"  
HOME_URL="https://www.ubuntu.com/"  
SUPPORT_URL="https://help.ubuntu.com/"  
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"  
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"  
VERSION_CODENAME=bionic  
UBUNTU_CODENAME=bionic`

Here is an example where the container is specified within your submission script:

```
#PBS -l walltime=1:30:00  
#PBS -l nodes=1:ppn=8  
#PBS -l mem=8gb  
#PBS -j oe  
#PBS -r n  
#PBS -m bae  
#PBS -M abf123@psu.edu  
#PBS -q hprc  
#PBS -A ics-hprc  
#PBS -v SINGULARITY_CONTAINER="/storage/work/abc123/singularity/bionic-base.simg"
```


#### 8.4 Specifying a Custom Bash Environment on HPRC

Some jobs may be best served by custom bash environments, especially those run within containers that do not support modules or other environment variables supported on ACI-b directly. A custom bash environment can be specified with a qsub variable on the command line or within your submission script.

Here’s an example on the command line:

`qsub -I -v SINGULARITY_CONTAINER="/storage/work/abc123/singularity/bionic-base.simg" -v BASH_ENV="/storage/abc123/.bashrc_ubuntu" -q hprc -A epo2-hprc -l nodes=1:ppn=20 -l pmem=5gb -l walltime=16:30:00`

Here’s an example within the submission script:

```
#PBS -l walltime=1:30:00  
#PBS -l nodes=1:ppn=8  
#PBS -l mem=8gb  
#PBS -j oe  
#PBS -r n  
#PBS -m bae  
#PBS -M abf123@psu.edu  
#PBS -q hprc  
#PBS -A ics-hprc  
#PBS -v SINGULARITY_CONTAINER="/storage/work/abc123/singularity/bionic-base.simg"  
#PBS -v BASH_ENV="/storage/abc123/.bashrc_ubuntu"
```


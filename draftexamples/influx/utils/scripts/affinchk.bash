#!/bin/bash

#Input
jobid=${1}

#Administrative items
readonly SCRIPT=$(basename $0)
readonly AUTHOR="ICS-Justin Petucci <jmp579@psu.edu>"
readonly REVISION="1.0"
readonly DATE="2018-08-31"

# Check arguments before continuing
if [ $# -ne 1 ]; then
   echo "Usage: ${SCRIPT} <jobid> "
   echo ""
   echo "Author: ${AUTHOR}"
   echo "Date:   ${DATE}"
   echo ""
   exit 1
fi

#SSH to master node and print 2 cycles of top
nodename=`qstat -n1t | grep ${jobid} | awk '{print $12}' | awk -F '/' '{print $1}'`
ssh ${nodename} /bin/bash << EOF
top -n2b -u $USER
EOF

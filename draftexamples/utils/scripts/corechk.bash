#!/bin/bash

NODE=${1}
cwd=`pwd`
# Administrative items
readonly SCRIPT=$(basename $0)
readonly AUTHOR="Justin Petucci <jmp579@psu.edu>"
readonly REVISION="1.0"
readonly DATE="2017-08-18"

# Check arguments before continuing
if [ $# -ne 1 ]; then
   echo "Usage: ${SCRIPT} <node>"
   echo ""
   echo "Author: ${AUTHOR}"
   echo "Date:   ${DATE}"
   echo ""
   exit 1
fi

#exit if node has no jobs running
qstatout=$(sudo `which qstat` -n1t | grep ${NODE}\/)
if [ "${qstatout}" = "" ]; then
echo "No jobs on ${NODE}"
exit 1
fi

#Print PBS JOB Info
echo "---PBS ALLOCATIONS---"
printf "%-8s %-7s %-5s %-12s %-7s %-10s\n" "USER" "NCORES" "MEM" "JOBID" "STATUS" "TORQUE-AFFINITY"
sudo `which qstat` -n1t | grep ${NODE}\/ | awk '{print $2" "$12" "$8" "$10" "$1}' | sed 's/\..*$//' | sort | while read PBSUSER PBSNODES PBSMEM PBSSTATUS PBSJOBID
do
  ALLTASKS=0
  CORES=$(echo ${PBSNODES} | egrep -o "${NODE}\/[0-9,-]*" | sed "s/${NODE}\///;s/,/ /g" )
  CORES2=$(sudo qstat -f1 ${PBSJOBID} | grep cpuset_string | awk '{print $3}' | tr '+' '\n' | grep ${NODE} | sed 's/.*://' | tr , '\n' | sort -n | paste -sd, -) 
 for PALLOC in $CORES
  do
    if [[ $PALLOC =~ [0-9]*-[0-9]* ]]
    then
      eval let ALLTASKS+=$(echo ${PALLOC//-/ } | awk '{print $2+1"-"$1}')
    else
      let ALLTASKS+=1
    fi
  done
  printf "%-8s %-7d %-5s %-12s %-7s %-10s\n" ${PBSUSER} ${ALLTASKS} ${PBSMEM} ${PBSJOBID} ${PBSSTATUS} ${CORES2} 
done

echo ''

#Print compute node top information and pid taskset
echo "---TOP for ${NODE}---"
printf "%-4s %-7s %-8s %-8s %-6s %-15s %-12s %-9s\n" "NUM" "PID" "USER" "%CPU" "CORE" "COMMAND" "TIME" "TASKSET"

ssh ${NODE} /bin/bash << EOF
top -n1b > $cwd/tmpfile1
EOF

for userid in $(sudo qstat -nt1 | grep ${NODE} | awk '{print $2}' | sort | uniq)
do
grep $userid tmpfile1 | awk '{ if ($9 > 5 ) print $1,$2,$9,$12,$13,$11}' >> tmpfile2
done

ssh ${NODE} "for pid in \$(awk '{print \$1}' $cwd/tmpfile2); do taskset -pc \$pid | awk '{print \$6}' >> $cwd/tmpfile3; done "

#exit if no processes owned by users are running on node
if [ -s tmpfile3 ]; then
:
else
echo "Users have no processors on ${NODE}"
exit 1
fi

nl tmpfile2 > tmpfile4
paste tmpfile4 tmpfile3 | awk '{ printf "%-4s %-7s %-8s %-8s %-6s %-15s %-12s %-9s\n", $1,$2,$3,$4,$5,$6,$7,$8}'
echo -ne "unique cores in use on ${NODE} = "; awk '{print $4}' tmpfile2 | sort | uniq | wc -l
rm tmpfile2 tmpfile3 tmpfile1 tmpfile4

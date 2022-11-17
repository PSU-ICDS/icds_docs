#!/bin/bash

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# rankfile.sh
#
# Justin Petucci
# jmp579@psu.edu
# 
# OpenMPI rankfile generator
# version 10202017
#
# Run with ./rankfile.sh || bash rankfile.sh
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

NCORES=`cat $PBS_NODEFILE | wc -l`
NODES=( `cat "$PBS_NODEFILE"` )
UNODES=( `uniq "$PBS_NODEFILE"` )
JOBID=`echo $PBS_JOBID | awk -F '.' '{print $1}'`

sequence() {
while (( $# > 0 )); do
if grep -q '[[:digit:]]\+-[[:digit:]]\+' <<< "$1"; then
echo -n $(seq $(sed 's/-/ /' <<< "$1"))' '
elif grep -q '[[:digit:]]\+' <<< "$1"; then
echo -n "$1 "
fi

shift;
done
echo ''
}

count=0
for node in $(echo "${UNODES[*]}"); do

  coreid=( `sequence $(qstat -n1t | grep $JOBID | awk '{print $12}' | tr '+' '\n' | grep $node | awk -F '/' '{print $2}' | tr ',' ' ' )` )

  for ((  i = 0 ;  i < ${#coreid[@]};  i++  )); do
    echo "rank $count=$node slots=${coreid[$i]}"
    let count=count+1
  done

done




#!/bin/bash


username=${1}

#Administrative items
readonly SCRIPT=$(basename $0)
readonly AUTHOR="ICS-Justin Petucci <jmp579@psu.edu>"
readonly REVISION="1.0"
readonly DATE="2017-09-20"


for node in $(for user in ${username}; do sudo qstat -n1tu $user | grep comp | awk '{print $12}' | tr '+' '\n' | awk -F "/" '{print $1}' | sort | uniq ; done); do bash /gpfs/group/wff3/default/scripts/corechk.bash $node ; done


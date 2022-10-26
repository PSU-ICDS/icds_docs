#!/bin/bash


username=${1}

#Administrative items
readonly SCRIPT=$(basename $0)
readonly AUTHOR="ICS-Justin Petucci <jmp579@psu.edu>"
readonly REVISION="1.0"
readonly DATE="2017-11-10"


getent group $(sudo `which mam-list-accounts` | grep ${username} | awk '{print $1}') | awk -F ':' '{print $4}' | tr ',' '\n' | sort | uniq > log.users

for alloc in $(sudo `which mam-list-accounts` | grep ${username} | awk '{print $1}'); do sudo `which mam-list-usagerecords` -a ${alloc} --show Id,Instance,Charge,User,Account,Nodes,Processors,StartTime,EndTime -s "$(date "+%Y-%m-%d" -d "90 days ago")" > log.usage.${alloc}; done

for file in $(ls -lt | grep log.usage | awk {'print $9'}); do for user in $(cat log.users); do amt=`grep -w $user $file | awk '{print $3}' | awk '{count=count+$NF}END{print count}'` ; echo $user $amt >> tmp_$file; done; awk 'NF==2' tmp_$file > usage_$file; done

#!/bin/bash

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# compareAccountsAndReservations.sh
#
# Adam Lavely - adam.lavely@psu.edu
# Fall 2017
# 
# Compare the reservation with what the 
# account should have
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Prep the files/locations 
rm *.logfile log.* 

# Get the files (so we only have to do the function calls once)
sudo `which mam-list-accounts`  -A > log.mamListAccountsa
sudo `which showres` > log.res

# Get rid of the open allocation
grep -v open log.mamListAccountsa > log.mamListAccounts

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Cycle through all of the allocations
for allocName in $(tail -n +3 log.mamListAccounts | awk '{print $1}')
do	
	# Find the number of processors assigned to each of the allocations
	moabVal=$(grep ${allocName} log.mamListAccounts | awk '{split($3,a,":"); split(a[1],b,"@"); print b[1]*b[2] }' )
	resVal=$(grep ${allocName} log.res | awk '{print $7}' | awk -F '/' '{print $2}')
	
	# If nothing is greped, put a 0
	moabVal="${moabVal:-0}"
	resVal="${resVal:-0}"

	if [ $moabVal = $resVal ]; 
	then	
		echo $allocName,${moabVal},${resVal} >> goodAllocations.logfile
	else
		echo $allocName >> badAllocations.logfile
		echo "Reservation = ${resVal}" >> badAllocations.logfile
		echo "mam-list-accounts = ${moabVal}" >> badAllocations.logfile
		grep ${allocName} log.mamListAccounts >> badAllocations.logfile
		echo " " >> badAllocations.logfile
	fi	
done

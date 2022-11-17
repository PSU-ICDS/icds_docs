#!/bin/bash

#Administrative items
readonly SCRIPT=$(basename $0)
readonly AUTHOR="ICS-Justin Petucci <jmp579@psu.edu>"
readonly REVISION="1.0"
readonly DATE="2018-09-12"


# Check arguments before continuing
if [ $# -ne 0 ]; then
   echo "Usage: ${SCRIPT} <emailaddress>"
   echo ""
   echo "Author: ${AUTHOR}"
   echo "Date:   ${DATE}"
   echo ""
   exit 1
fi
echo `date` > $HOME/storage_quota.txt
/usr/lpp/mmfs/bin/mmlsquota --block-size=auto -j dml129_default group >> $HOME/storage_quota.txt

for username1 in adp29@psu.edu jmp579@psu.edu 
do
echo "This is an automated message. The attached file contains the current usage of the dml129 storage allocation on the ICDS-ACI System." | mail -s "dml129 ICDS-ACI Storage  `date`" -r jmp579@psu.edu -a $HOME/storage_quota.txt $username1

done

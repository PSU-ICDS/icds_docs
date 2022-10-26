#!/bin/bash
# Script written by Ghanghoon "Will" Paik (gip5038@psu.edu)
# Date: 11/19/2019
# Last modified: 5/12/2021

# Check for inputs
if [[ $# -gt 1 ]]; then
	echo -e "Error: \tToo many inputs"
	echo -e "Usage: \t$(basename $0) <app> or <desktop> or <all>\n\tOr, $(basename $0) for desktop"
	echo "List of apps: desktop, ansys, avizo, abaqus, comsol, matlab, tecplot, rserver, jupyter, jupyter-byoe"
        echo " "
	exit 1
elif [[ $1 == "-help" || $1 == "--help" ]]; then
	echo -e "Usage: \t$(basename $0) <app> or <desktop> or <all>\n\tOr, $(basename $0) for desktop"
	echo "List of apps: desktop, ansys, avizo, abaqus, comsol, matlab, tecplot, rserver, jupyter, jupyter-byoe"
        echo " "
	exit 1
elif [[ $# -eq 0 ]]; then
	input=desktop
fi

#input=${1,,}
input=$1

#pbsnodes -l | grep comp-ic* > tmp_ood_sessions

down=$(pbsnodes -l | grep comp-ic* | wc -l)
#down=$(less tmp_ood_sessions | grep comp-ic | wc -l)

if [[ $down -ge 1 ]]; then
	echo " "
	echo -e "No. down IC nodes: $down"
else
	echo " "
	echo "All IC nodes are online"
fi

echo " "

if [[ -z $input ]]; then
	input=desktop
fi

echo "Checking OoD Interactive ${input^} sessions (comp-ic only)"

echo " "

qstat -n1t | grep open | grep -E 'R|Q' > tmp_ood_sessions

if [[ ! -z $input && $input != "all" ]]; then
	if [[ $input == "jupyter" || $input == "jupyter-byoe" ]]; then
		Nproc_R=$(less tmp_ood_sessions | grep R | grep comp-ic* | grep s$input | awk '{TotProc += $7} END {print TotProc}')
                if [[ -z $Nproc_R ]]; then
                        Nproc_R=0
                fi
		less tmp_ood_sessions | grep R | grep comp-ic* | grep s$input | wc -l | awk '{print "----->\tCurrently running OoD '${input^}' sessions: "$1 " (or '$Nproc_R' procs)"}'
		less tmp_ood_sessions | grep Q | grep s$input | wc -l | awk '{print "----->\tCurrently queued OoD '${input^}' sessions: "$1}'
	else
		Nproc_R=$(less tmp_ood_sessions | grep R | grep comp-ic* | grep g$input | awk '{TotProc += $7} END {print TotProc}')
		if [[ -z $Nproc_R ]]; then
			Nproc_R=0
		fi
		less tmp_ood_sessions | grep R | grep comp-ic* | grep g$input | wc -l | awk '{print "----->\tCurrently running OoD '${input^}' sessions: "$1 " (or '$Nproc_R' procs)"}'
		less tmp_ood_sessions | grep Q | grep g$input | wc -l | awk '{print "----->\tCurrently queued OoD '${input^}' sessions: "$1}'
	fi
	echo " "
elif [[ $input == "all" ]]; then
	list="desktop ansys avizo abaqus comsol matlab tecplot rserver"
	for input in $list
	do 
        	Nproc_R=$(less tmp_ood_sessions | grep R | grep comp-ic* | grep g$input | awk '{TotProc += $7} END {print TotProc}')
		if [[ -z $Nproc_R ]]; then
			Nproc_R=0
		fi

		less tmp_ood_sessions | grep R | grep comp-ic* | grep g$input | wc -l | awk '{print "----->\tCurrently running OoD '${input^}' sessions: "$1 " (or '$Nproc_R' procs)"}'
        	less tmp_ood_sessions | grep Q | grep g$input | wc -l | awk '{print "----->\tCurrently queued OoD '${input^}' sessions: "$1}'
        	echo " "
	done
	# For jupyter servers:
	list="jupyter jupyter-byoe"
	for input in $list
        do
                Nproc_R=$(less tmp_ood_sessions | grep R | grep comp-ic* | grep s$input | awk '{TotProc += $7} END {print TotProc}')
                if [[ -z $Nproc_R ]]; then
                        Nproc_R=0
                fi

                less tmp_ood_sessions | grep R | grep comp-ic* | grep s$input | wc -l | awk '{print "----->\tCurrently running OoD '${input^}' sessions: "$1 " (or '$Nproc_R' procs)"}'
                less tmp_ood_sessions | grep Q | grep s$input | wc -l | awk '{print "----->\tCurrently queued OoD '${input^}' sessions: "$1}'
                echo " "
        done

fi

less tmp_ood_sessions | grep R | grep comp-ic* | wc -l | awk '{print "----->\t" $1 " out of " 480 - 10*'${down}' " OoD sessions are in use now"}'
Nproc_R=$(less tmp_ood_sessions | grep R | grep comp-ic* | awk '{TotProc += $7} END {print TotProc}')
echo | awk '{print "----->\t" "'$Nproc_R' out of " 40*24 - 40*'$down' " OoD procs are in use now"}'


echo " "

rm tmp_ood_sessions

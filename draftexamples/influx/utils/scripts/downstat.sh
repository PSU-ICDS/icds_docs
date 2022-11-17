#!/bin/bash
# Written by Ghanghoon "Will" Paik (gip5038@psu.edu)
# July 22 2019

total=`pbsnodes -ln | wc -l`
compbc=`pbsnodes -ln | grep "comp-bc" | wc -l`
compsc=`pbsnodes -ln | grep "comp-sc" | wc -l`
comphc=`pbsnodes -ln | grep "comp-hc" | wc -l`
compic=`pbsnodes -ln | grep "comp-ic" | wc -l`
compgc=`pbsnodes -ln | grep "comp-gc" | wc -l`
complc=`pbsnodes -ln | grep "comp-lc" | wc -l`
cyberlamp=`pbsnodes -ln | grep "comp-cl" | wc -l`
compclgc=`pbsnodes -ln | grep "comp-clgc" | wc -l`
compclpc=`pbsnodes -ln | grep "comp-clpc" | wc -l`
compclhc=`pbsnodes -ln | grep "comp-clhc" | wc -l`
aci=`expr $total - $cyberlamp`

printf "|%-42s|\n" | tr ' ' -
printf "|%-42s|\n" "############ NODE DOWN STATUS ############"
printf "|%-42s|\n" | tr ' ' -
printf "Total Down/Offline = \t$total\n\n" | expand -t 40

printf "Total ACI nodes Down/Offline = \t$aci\n" | expand -t 40
printf "    *Basic nodes = \t$compbc\n" | expand -t 40
printf "    *Standard nodes = \t$compsc\n" | expand -t 40
printf "    *High mem nodes = \t$comphc\n" | expand -t 40
printf "    *IC nodes = \t$compic\n" | expand -t 40
printf "    *GPU nodes = \t$compgc\n" | expand -t 40
printf "    *Legacy nodes = \t$complc\n\n" | expand -t 40

printf "Total CyberLAMP nodes Down/Offline = \t$cyberlamp\n" | expand -t 40
printf "    *GPU nodes = \t$compclgc\n" | expand -t 40
printf "    *Phi nodes = \t$compclpc\n" | expand -t 40
printf "    *High mem nodes = \t$compclhc\n" | expand -t 40

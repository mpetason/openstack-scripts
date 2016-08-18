#!/bin/bash
# Created by Michael Petersen 2016
#
#
#


## This searches for the ID's of controller nodes.
contNum=$(fuel node 2>/dev/null| grep cont | awk '{print $1}'| sort)

## This searches for the ID's of compute nodes.
compNum=$(fuel node 2>/dev/null| grep comp | awk '{print $1}'| sort)

## List of filenames we need to edit on a Controller node
## after making the updates to Keystone.
contFilenames=(
	/etc/neutron/metadata_agent.ini 
	/etc/neutron/api-paste.ini
	/etc/neutron/neutron.conf
	/etc/nova/nova.conf
	)

compFilenames=(
	/etc/neutron/metadata_agent.ini
	/etc/nova/nova.conf
	)
	
for c in $contNum; do
	printf "Checking on Controller: ${c}\n"
	for f in ${contFilenames[*]}; do
		ssh -n -q root@node-$c "ps aux | grep -i " $f| awk '{print $12}'
	done
done	
#for c in $contNum; do
#	printf "Working on Controller: ${c}\n"
#	for f in ${contFilenames[*]}; do
#		printf "Updating file ${f}.\n"
#		ssh -n -q root@node-$c $sedCommand $f
#		printf "\n"
#
#	done
#done

#for h in $compNum; do
#	printf "Working on Compute: ${h}\n"
#	for f in ${compFilenames[*]}; do
#		printf "Updating file ${f}.\n"
#		ssh -n -q root@node-$c $sedCommand $f
#		printf "\n"
#	done
#done

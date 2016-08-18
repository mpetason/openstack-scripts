#!/bin/bash
# Created by Michael Petersen 2016
#
#
#

## Setup Service Names Array
serviceNamesCont=()
serviceNamesComp=()

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
		serviceNamesCont+=$(ssh -n -q root@node-$c "ps aux | grep -i " $f| grep -i '/usr/bin/*' | awk '{print $12}')
	done
done	

for c in $compNum; do
	printf "Checking on Computes: ${c}\n"
	for f in ${contFileNames[*]}; do 
		serviceNamesComp+=$(ssh -n -q root@node-$c "ps aux | grep -i " $f| grep -i '/usr/bin/*' | awk '{print $12}')
	done
done

printf "Services on the Controller Nodes"

for s in $serviceNamesCont; do
	printf $s
	printf "\n"
done | sort -u

printf "Services on the Compute Nodes"

for s in $serviceNamesComp; do
	printf $s
	printf "\n"
done | sort -u

#!/bin/bash
# Created by Michael Petersen 2016
#
#
#

## Replace the oldAdmin endpoint with the current value
## of your admin endpoint in keystone. 
oldAdmin=http://10.109.1.2:35357

## Replace the newAdmin endpoint with https + the hostname 
## of your current public endpoint in keystone. Remember
## to keep :35357 as it is the admin port.
newAdmin=https://public.fuel.local:35357

## Builds the Sed command
sedCommand="sed -i \"s|${newAdmin}|${oldAdmin}|g\""

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
	printf "Working on Controller: ${c}\n"
	for f in ${contFilenames[*]}; do
		printf "Updating file ${f}.\n"
		ssh -n -q root@node-$c $sedCommand $f
		printf "\n"

	done
done

for h in $compNum; do
	printf "Working on Compute: ${h}\n"
	for f in ${compFilenames[*]}; do
		printf "Updating file ${f}.\n"
		ssh -n -q root@node-$c $sedCommand $f
		printf "\n"
	done
done

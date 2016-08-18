#!/bin/bash
#
#
#
#

## Replace the oldAdmin endpoint with the current value
## of your admin endpoint in keystone. 
oldAdmin=http://10.109.1.2:35357

## Replace the newAdmin endpoint with https + the hostname 
## of your current public endpoint in keystone. Remember
## to keep :35357 as it is the admin port.
newAdmin=http://public.fuel.local:35357

## This searches for the ID's of controller nodes.
contNum=$(fuel node| grep cont | awk '{print $1}'| sort)

## This searches for the ID's of compute nodes.
compNum=$(fuel node| grep comp | awk '{print $1}'| sort)

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

## Tests for the Old Admin value in files on Controllers.
for c in $contNum; do
	printf "Working on Controller: ${c}\n"
	for f in ${contFilenames[*]}; do
		printf "[OLD]Searching for ${oldAdmin} in ${f}.\n"
		ssh -n -q node-$c grep -i $oldAdmin $f
		printf "\n"
	done
done

## Tests for the New Admin value in files on Controllers. 
for n in $contNum; do 
	printf "Working on Controller: ${c}\n"
	for f in ${contFilenames[*]}; do
		printf "[NEW]Searching for ${newAdmin} in ${f}.\n"
		ssh -n -q node-$c grep -i $newAdmin $f
		printf "\n"
	done

## Tests for the Old Admin in files on the Computes.
for h in $compNum; do
	printf "Working on Compute: ${h}\n"
	for f in ${compFilenames[*]}; do
		printf "[OLD]Searching for ${oldAdmin} in ${f}.\n"
		ssh -n -q node-$c grep -i ${oldAdmin} $f
		printf "\n"
	done
done

## Tests for the New Admin in files on the Computes. 
for h in $compNum; do
	printf "Working on Compute: ${h}\n"
	for f in ${compFilenames[*]}; do
		printf "[NEW]Searching for ${newAdmin} in ${f}.\n"
		ssh -n -q node-$c grep -i ${newAdmin} $f
		printf "\n"
	done
done

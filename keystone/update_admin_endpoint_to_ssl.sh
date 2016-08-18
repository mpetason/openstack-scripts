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
contNum=$(fuel node| grep cont | awk '{print $1}')

## This searches for the ID's of compute nodes.
compNum=$(fuel node| grep comp | awk '{print $1}')

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
	printf "Working on Controller: ${c}"
	printf "\n"
	for f in ${fileNames[*]}; do
		ssh -n -q node-$c grep -i 35357 $f
	done
done

for h in $compNum; do
	printf "Working on Compute: ${h}"
	printf "\n"
	for f in ${fileNames[*]}; do
		ssh -n -q node-$c grep -i 35357 $f
	done
#for c in $conNum; do
#    ssh -n node-$c sed -i -e 's/$oldAdmin/$newAdmin/g' $filename
#done


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

contNum=$(fuel node|grep cont | awk '{print $1}')

## List of filenames we need to edit on a Controller node
## after making the updates to Keystone.
fileNames=(
	/etc/neutron/metadata_agent.ini 
	/etc/neutron/api-paste.ini
	/etc/neutron/neutron.conf
	/etc/nova/nova.conf
	)


for c in $contNum; do
	printf $c
done

for f in ${fileNames[*]}; do
	printf $f
done	

#for c in $conNum; do
#    ssh -n node-$c sed -i -e 's/$oldAdmin/$newAdmin/g' $filename
#done


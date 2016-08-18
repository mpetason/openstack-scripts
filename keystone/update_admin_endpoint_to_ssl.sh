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

## We have the option to use different fields based on needs.
## By default we'll use field 1, which is the ID of the node.
## We can use fiel 10, which is the IP of the node, if the
## node isn't reachable by using `ssh node-#`
fieldNumber=1

## Here we pull the values based on the field. If the field 
## is equal to 1 then we'll have a list of IDs, if it is 
## field 10 we'll receive a list of IPs.
contNum=$(fuel node |grep cont | awk '{print $fieldNumber}')

compNum=$(fuel node|grep comp | awk '{print $fieldNumber}')

## List of filenames we need to edit on a Controller node
## after making the updates to Keystone.
fileNames(
	'/etc/neutron/metadata_agent.ini' 
	'/etc/neutron/api-paste.ini'
	'/etc/neutron/neutron.conf'
	'/etc/nova/nova.conf'
	)


for c in $contNum; do
	echo $c
done

for c in $compNum; do
	echo $c
done
#for c in $conNum; do
#    ssh -n node-$c sed -i -e 's/$oldAdmin/$newAdmin/g' $filename
#done


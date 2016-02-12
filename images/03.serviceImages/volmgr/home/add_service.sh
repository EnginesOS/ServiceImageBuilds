#!/bin/bash


service_hash="$1"

#. /home/engines/scripts/functions.sh

#load_service_hash_to_environment

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

#FIXME make engines.internal settable

	if test -z "${service_name}"
	then
		echo Error:Missing service_name
        exit -1
    fi
  	if test -z ${user}
	then
		echo Error:missing user
        exit -1
    fi  
     	if test -z ${group}
	then
		echo Error:missing group
        exit -1
    fi  
    	if test -z ${parent_engine}
	then
		echo Error:missing parent_engine
        exit -1
    fi  
    
    sudo /home/engines/scripts/create_volume.sh ${parent_engine} ${service_name} ${user} ${group}
    if $? -eq 0
	then 
		echo "Success"
		exit 0
 	fi
 exit 127
 	

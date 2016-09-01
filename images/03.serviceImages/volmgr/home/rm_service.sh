#!/bin/bash

service_hash="$1"



 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env
#FIXME make engines.internal settable

	
  	if test -z ${service_name}
	then
		echo Error:missing service_name
        exit 127
    fi  
    	if test -z ${parent_engine}
	then
		echo Error:missing parent_engine
        exit 127
    fi  
    
 sudo -n /home/engines/scripts/delete_volume.sh ${parent_engine} ${service_name} 
    if test $? -eq 0
	then 
		echo "Success"
		exit 0
 	fi
 exit 127

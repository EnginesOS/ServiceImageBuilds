#!/bin/bash

if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

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

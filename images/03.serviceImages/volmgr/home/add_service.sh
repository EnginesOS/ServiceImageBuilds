#!/bin/bash


service_hash=`echo  "$*" | sed "/\*/s//STAR/g"`

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

#FIXME make engines.internal settable

	if test -z "${cron_job}"
	then
		echo Error:Missing cron_job
        exit -1
    fi
  	if test -z ${title}
	then
		echo Error:missing title
        exit -1
    fi  
    	if test -z ${parent_engine}
	then
		echo Error:missing parent_engine
        exit -1
    fi  
    
    sudo /home/engines/scripts/create_volume.sh ${parent_engine} ${name} ${user} ${group}
    if $? -eq 0
	then 
		echo "Success"
		exit 0
 	fi
 exit 127
 	

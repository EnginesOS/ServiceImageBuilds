#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

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
    
sudo -n /home/engines/scripts/fs/delete_volume.sh ${parent_engine} ${service_name} 
if test $? -eq 0
 then 
	echo "Success"
    exit 0
fi
exit 127

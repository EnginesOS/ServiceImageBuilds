#!/bin/bash


. /home/engines/functions/params_to_env.sh
params_to_env

required_values="parent_engine service_name user group"
check_required_values
#FIXME make engines.internal settable


sudo -n  /home/engines/scripts/services/_create_volume.sh
if test $? -eq 0
 then 
	echo "Success"
    exit 0
fi
exit 127
 	

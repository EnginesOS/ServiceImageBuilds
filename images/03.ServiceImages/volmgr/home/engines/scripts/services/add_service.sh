#!/bin/bash


. /home/engines/functions/params_to_env.sh
params_to_env

required_values="parent_engine service_name user group"
check_required_values

export parent_engine
export service_name
export user
export group

sudo -n  /home/engines/scripts/services/_create_volume.sh
if test $? -eq 0
 then 
	echo "Success"
    exit 0
fi
exit 127
 	

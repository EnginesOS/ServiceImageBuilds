#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

#FIXME make engines.internal settable

required_values="parent_engine service_name"
check_required_values

sudo -n /home/engines/scripts/services/_delete_volume.sh
 
if test $? -eq 0
 then 
	echo "Success"
    exit 0
fi
exit 127

#!/bin/bash


. /home/engines/functions/params_to_env.sh
params_to_env

required_values="parent_engine service_name user group"
check_required_values

export parent_engine
export service_name
export user
export group

if test -z $is_secret
 then
   sudo -n /home/engines/scripts/services/_create_volume.sh
else
  volume_src=`echo $volume_src | sed "s/\.\.//g"`
    echo $volume_src | grep "^/var/lib/engines/secrets/$container_type" >/dev/null
    if test $? -ne 0
     then
      echo "Invalid volume:$volume_src"
      exit 2
    fi      
   sudo -n /home/engines/scripts/services/_create_secret.sh
fi

if test $? -eq 0
 then 
	echo "Success"
    exit 0
fi
exit 127
 	

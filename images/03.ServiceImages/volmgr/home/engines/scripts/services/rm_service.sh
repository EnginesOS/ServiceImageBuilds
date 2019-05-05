#!/bin/sh

#. /home/engines/functions/params_to_env.sh
#params_to_env
 . /home/engines/functions/checks.sh
#FIXME make engines.internal settable

required_values="parent_engine service_name"
check_required_values

export parent_engine
export service_name
export container_type

if test -z $voltype
 then
  voltype=dir
fi

#FIX ME add more values to required
required_values="parent_engine "
  check_required_values

if  ! test -z $home_type 
  then
   if test $home_type = all
    then
     sudo -n /home/engines/scripts/services/_remove_homes.sh
   elif test $home_type = seperate
      then
      echo $homes |  sudo -n /home/engines/scripts/services/_remove_all_homes.sh
   else
     echo "Unknown type"  
     exit 127
   fi  
elif test -z $is_secret
 then
   sudo -n /home/engines/scripts/services/_delete_volume.sh
 else 
   echo $volume_src | grep "^/var/lib/engines/secrets/$container_type" >/dev/null
    if test $? -ne 0
     then
      echo "invalid volume $volume_src"
      exit 1
    fi
   sudo -n /home/engines/scripts/services/_delete_secret.sh
fi  
 
if test $? -eq 0
 then 
	echo "Success"
    exit 0
fi
exit 127

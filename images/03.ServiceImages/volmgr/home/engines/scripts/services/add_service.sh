#!/bin/sh


#. /home/engines/functions/params_to_env.sh
#params_to_env
 . /home/engines/functions/checks.sh
export parent_engine
export container_type
export service_name
export service_handle
export user
export group

if test -z $voltype
 then
  voltype=dir
fi

#FIX ME add more values to required
required_values="parent_engine "
  check_required_values

if  ! test -z $home_type 
  then
   if test $home_type = seperate
    then
     echo $homes | sudo -n /home/engines/scripts/services/_create_homes.sh
   elif test $home_type = all
    then
     sudo -n /home/engines/scripts/services/_create_all_homes.sh
   else
    echo "Unknown type"  
    exit 127
   fi  
elif test -z $is_secret
 then
  required_values="parent_engine service_name user group"
  check_required_values
    volume_src=`echo $volume_src | sed "s/\.\.//g"`
   # echo $volume_src | grep "^/var/lib/engines/$container_type" >/dev/null
    #if test $? -ne 0
     #then
      #echo "Invalid volume:$volume_src"
      #exit 2
    #fi      
  sudo -n /home/engines/scripts/services/_create_volume.sh
else
   sudo -n /home/engines/scripts/services/_create_secret.sh
fi

if test $? -eq 0
 then 
	echo "Success"
    exit 0
fi
exit 127
 	

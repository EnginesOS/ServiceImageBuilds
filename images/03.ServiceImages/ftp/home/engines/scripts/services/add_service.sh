#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env


required_values="username password title folder"
check_required_values


#

if ! test -z $rw_access 
 then
  if test $rw_access = true
   then
     access=rw
   else
     access=ro
   fi
 else
    access=ro
fi   

export ftp_gid access username password title folder service_handle service_container_name parent_engine
sudo -n /home/engines/scripts/services/_add_service.sh


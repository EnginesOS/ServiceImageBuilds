#!/bin/sh

 . /home/engines/functions/checks.sh

required_values="username password  folder"
check_required_values

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

export ftp_gid access username password  folder service_handle service_container_name parent_engine
sudo -n /home/engines/scripts/services/_add_service.sh


#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env
 
if test -z $log_file_path
 then 
  echo "no path"
  exit -1
 fi
 
if test -z $parent_engine
 then 
  echo "no engine"
  exit -1
 fi 

if ! test -d  /home/saved/$parent_engine/
 then
    mkdir -p /home/saved/$parent_engine/
fi

if test -z $service_handle
 then
   service_handle=`basename $log_file_path`
fi

echo "/var/log/engines/$log_file_path{" > /home/saved/$parent_engine/$service_handle.entry
cat /home/tmpls/log_rotation_entry | sed "/ROTATE/s//$rotate/" |\
                sed    "/CYCLE/s//$cycle/"  >> /home/saved/$parent_engine/$service_handle.entry


cat /home/saved/$parent_engine/*entry > /home/logrotate.d/$parent_engine

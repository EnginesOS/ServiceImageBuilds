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

if ! test -d
 then 
	mkdir /home/saved/$parent_engine/
fi


rm /home/saved/$parent_engine/$service_handle.entry

cat /home/saved/$parent_engine/*entry > /home/logrotate.d/$parent_engine

 
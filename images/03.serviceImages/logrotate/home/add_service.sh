#!/bin/bash

service_hash=$1

 . /home/defaults
 
 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env
 
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

it ! test -d
 then 
	mkdir /home/saved/$parent_engine/
fi

eval string=`cat /home/tmpls/log_rotation_entry` 
echo $string> /home/saved/$parent_engine/$service_handle.entry

cat /home/saved/$parent_engine/*entry > /home/logrotate.d/$parent_engine

 
#!/bin/bash

if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

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

if ! test -d
 then 
	mkdir /home/saved/$parent_engine/
fi


rm /home/saved/$parent_engine/$service_handle.entry

cat /home/saved/$parent_engine/*entry > /home/logrotate.d/$parent_engine

 
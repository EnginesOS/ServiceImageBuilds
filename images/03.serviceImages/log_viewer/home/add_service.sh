#!/bin/bash

service_hash=$1


 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if ! test -d /home/saved/$parent_engine/
 then
 	mkdir -p /home/saved/$parent_engine/
 fi
 
 case $log_type in
 nginx)
 log_file_path=services/nginx/$parent_engine/$log_file_path
 ;;
 
 apache)
 if test -z $ctype
  then
   ctype=container
  fi
 log_file_path=${ctype}s/$parent_engine/$log_file_path
 ;;
 
 raw)
 if test -z $ctype
  then
   ctype=engine 
  fi
 log_file_path=${ctype}s/$parent_engine/$log_file_path
 ;;
 
 esac
 
 conf=/home/saved/$parent_engine/$log_name
if ! test -f /var/log/engines/$log_file_path
 then
 	echo "Log file must exist"
 	exit 127
 fi
 
echo  \"$parent_engine_$log_name\": { \"display\" : \"$parent_engine $log_name\", \"path\"    : \"/var/log/engines/$log_file_path\",  > /tmp/.conf
cat  /home/tmpls/$log_type >>  /tmp/.conf
mv  /tmp/.conf $conf
/home/build_config.sh
 
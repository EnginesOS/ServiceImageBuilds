#!/bin/bash

service_hash=$1


 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if ! test -d /home/saved/$parent_engine/
 then
 	mkdir -p /home/saved/$parent_engine/
 fi
 
 conf=/home/saved/$parent_engine/$log_name

echo  \"$parent_engine_$log_name\": { \"display\" : \"$parent_engine $log_name\", \"path\"    : \"/var/log/engines/$log_file_path\",  > /tmp/.conf
cat  /home/tmpls/$log_type >>  /tmp/.conf
mv  /tmp/.conf $conf
/home/build_config.sh
 
#!/bin/bash

service_hash=$1


 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if ! test -d /home/saved/$parent_engine/
 then
 	mkdir -p /home/saved/$parent_engine/
 fi
 
 string=`cat /home/tmpls/$log_type`
eval echo $string > /home/saved/$parent_engine/$log_name 
/home/build_config.sh


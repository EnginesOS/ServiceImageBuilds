#!/bin/bash

service_hash=$1


 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if ! test -d 
 then
 	mkdir -p /home/saved/$parent_engine/
 fi
echo `cat /home/tmpls/$log_type` > /home/saved/$parent_engine/$log_name 
/home/build_config.sh


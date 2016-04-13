#!/bin/bash

service_hash=$1

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

rm /home/saved/$parent_engine/$log_name 
/home/build_config.sh

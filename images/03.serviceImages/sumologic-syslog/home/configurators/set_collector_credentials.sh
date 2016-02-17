#!/bin/bash

service_hash=$1

echo \'$1\' >/home/configurators/saved/credentials

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env

 
exit 0

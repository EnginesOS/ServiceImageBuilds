#!/bin/bash

service_hash=$1

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env


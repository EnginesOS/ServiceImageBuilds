#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/default_destination
            


#. /home/engines/scripts/functions.sh

#load_service_hash_to_environment

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if test -f /home/configurators/saved/system_backup
 then
 	/home/configurators/set_system_backup.sh `cat /home/configurators/saved/system_backup`
 fi


exit 0

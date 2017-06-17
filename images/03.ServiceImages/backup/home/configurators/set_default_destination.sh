#!/bin/bash

cat - > /home/configurators/saved/default_destination
 
cat /home/configurators/saved/default_destination | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if test -f /home/configurators/saved/system_backup
 then
 	cat /home/configurators/saved/system_backup | /home/configurators/set_system_backup.sh 
 fi


exit 0

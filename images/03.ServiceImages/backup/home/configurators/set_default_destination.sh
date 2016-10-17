#!/bin/bash

cat - > /home/configurators/saved/default_destination
            


cat /home/configurators/saved/default_destination | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if test -f /home/configurators/saved/system_backup
 then
 	/home/configurators/set_system_backup.sh `cat /home/configurators/saved/system_backup`
 fi


exit 0

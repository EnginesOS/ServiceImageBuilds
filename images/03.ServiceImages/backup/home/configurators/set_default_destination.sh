#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/configurators/saved/default_destination
parms_to_file_and_env


if test -f /home/configurators/saved/system_backup
 then
 	cat /home/configurators/saved/system_backup | /home/configurators/set_system_backup.sh 
 fi


exit 0

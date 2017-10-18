#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/default_destination
parms_to_file_and_env

if test -f /home/engines/scripts/configurators/saved/system_backup
 then
 	cat /home/engines/scripts/configurators/saved/system_backup | /home/engines/scripts/configurators/set_system_backup.sh 
fi


exit 0

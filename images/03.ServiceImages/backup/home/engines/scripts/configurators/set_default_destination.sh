#!/bin/sh


if test -f /home/engines/scripts/configurators/saved/system_backup
 then
 	cat /home/engines/scripts/configurators/saved/system_backup | /home/engines/scripts/configurators/set_system_backup.sh 
fi


exit 0

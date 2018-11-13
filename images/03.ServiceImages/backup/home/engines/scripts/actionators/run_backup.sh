#!/bin/sh


cd /home/backup
if test -z $backup_name
 then
   /home/engines/scripts/engine/run_duply.sh
else
  /home/engines/scripts/engine/run_duply.sh $backup_name backup
fi

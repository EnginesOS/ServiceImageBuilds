#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

cd /home/backup
if test -z $backup_name
 then
   /home/engines/scripts/backup/run_duply.sh
else
  /home/engines/scripts/backup/run_duply.sh $backup_name backup
fi

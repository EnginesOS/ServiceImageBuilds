#!/bin/sh

. /home/engines/functions/params_to_env.sh
parms_to_env

cd /home/backup
if test -z $backup_name
 then
   /home/backup/backup_run.sh
else
   sudo duply $backup_name backup
fi

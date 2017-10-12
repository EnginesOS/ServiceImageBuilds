#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

cd /home/backup
if test -z $backup_name
 then
   /home/backup_run.sh
else
  /home/run_duply $backup_name backup
fi

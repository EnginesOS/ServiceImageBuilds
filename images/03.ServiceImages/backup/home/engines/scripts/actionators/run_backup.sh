#!/bin/sh

cd /home/backup

if test -z $backup_name
 then
   /home/engines/scripts/engine/run_duply.sh
else
 if test -d /home/backup/.duply/$backup_name
  then
   /home/engines/scripts/engine/run_duply.sh $backup_name backup
 else
    echo '{"status":"error","message":"No Such backup '$backup_name'"}'
    exit 2
 fi
fi

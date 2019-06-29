#!/bin/sh

cd /home/backup
if test -f $Backup_ConfigDir/$backup/ssh_key
 then
  key_name=`cat $Backup_ConfigDir/$backup/ssh_key`
   extra_options="--ssh-options='"'-oProtocol=2 -oIdentityFile=/home/backup/.ssh/$key_name'"'"
fi    

if test -d /home/backup/.duply/$backup_name
  then
   /home/engines/scripts/engine/run_duply.sh $backup_name backup $extra_options --s3-use-new-style    
 else
    echo '{"status":"error","message":"No Such backup '$backup_name'"}'
    exit 2
 fi


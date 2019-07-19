#!/bin/sh

if test -z $backup_name 
then
 $backup_name = all
fi
 
cd /home/backup
if test -f $Backup_ConfigDir/$backup/ssh_key
 then
  key_name=`cat $Backup_ConfigDir/$backup/ssh_key`
   extra_options="--ssh-options='"'-oProtocol=2 -oIdentityFile=/home/backup/.ssh/$key_name'"'"
fi    

if test $backup_name = all
 then
    cd /home/backup/.duply
     for backup_dir in `ls`
      do
       if test -f $backup_dir/conf
         then
           /home/engines/scripts/engine/run_duply.sh $backup_dir backup $extra_options --s3-use-new-style
       fi    
      done  
elif test -d /home/backup/.duply/$backup_name
  then
   /home/engines/scripts/engine/run_duply.sh $backup_name backup $extra_options --s3-use-new-style    
 else
    echo '{"status":"error","message":"No Such backup '$backup_name'"}'
    exit 2
 fi


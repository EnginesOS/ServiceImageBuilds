#!/bin/sh

cp /home/engines/templates/backupduply_conf $1
key=`cat /home/backup/.gnupg/key_id`
dir=`dirname $1`
if test -f $dir/MAX_FULL_BACKUPS
 then
  MAX_FULL_BACKUPS_FILE=$dir/MAX_FULL_BACKUPS
else
 MAX_FULL_BACKUPS_FILE=/home/engines/scripts/configurators/saved/MAX_FULL_BACKUPS
fi
echo MAX_FULL_BACKUPS=`cat $MAX_FULL_BACKUPS_FILE` >> $1

 if test -z "$key"
 then
  echo "GPG_KEY='disabled'" >> $1
else
  pass=`cat /home/backup/.gnupg/pass_${key}`
  echo GPG_KEY=$key >> $1
  echo GPG_PW=$pass >> $1
fi
	

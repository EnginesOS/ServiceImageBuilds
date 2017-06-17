#!/bin/bash


if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env>/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env
echo "$*" >>/var/log/backup/rmbackup.log

Backup_ConfigDir=/home/backup/.duply/

ts=`date`
echo "$ts:$*" >>/var/log/backup/addbackup.log

export Backup_ConfigDir
export backup_name
export dest
export dest_user
export dest_pass
export parent_engine

 shift
 
while ! test -z $1
 do  
   service_hash=$1
   load_service_hash_to_environment
   echo calling /home/backup_scripts/$publisher_namespace/$type_path/rm_backup.sh $1
   /home/backup_scripts/$publisher_namespace/$type_path/rm_backup.sh $1
   shift
 done
 
 exit 0
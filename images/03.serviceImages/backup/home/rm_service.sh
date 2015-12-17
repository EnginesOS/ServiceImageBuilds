#!/bin/bash


service_hash=$1

. /home/engines/scripts/functions.sh

echo "$*" >>/var/log/backup/rmbackup.log

Backup_ConfigDir=/home/backup/.duply/


load_service_hash_to_environment

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
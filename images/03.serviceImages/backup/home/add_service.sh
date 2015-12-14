#!/bin/bash

service_hash=$1

. /home/engines/scripts/functions.sh

echo $1 >/home/configurators/saved/system_backup

 echo "$*" >>/var/log/backup/addbackup.log

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

while ! test -z $2
 do
     shift
	service_hash=$1

. /home/engines/scripts/functions.sh
	/home/backup_scripts/$publisher_namespace/$type_path/add_backup.sh $1
 done

#!/bin/bash

service_hash=$1


#sed "/\"\[/s//\[/" |  "/\]\"/s//\]/"

 echo $service_hash | sed "/\"\[/s//\[/" | sed "/\]\"/s//\]/"  | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

echo $1 >/home/configurators/saved/backup

 echo "$*" >>/var/log/backup/addbackup.log

Backup_ConfigDir=/home/backup/.duply/




ts=`date`
 echo "$ts:$*" >>/var/log/backup/addbackup.log
 

export Backup_ConfigDir
export backup_name
export dest_folder
export dest_proto
export dest_address
export dest_user
export dest_pass
export parent_engine
 shift
while ! test -z $1
 do
     echo $1 | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

echo calling /home/backup_scripts/$publisher_namespace/$type_path/add_backup.sh $1

	/home/backup_scripts/$publisher_namespace/$type_path/add_backup.sh $1

	shift
 done

 exit 0
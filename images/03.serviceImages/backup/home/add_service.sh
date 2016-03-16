#!/bin/bash

service_hash=$1


#sed "/\"\[/s//\[/" |  "/\]\"/s//\]/"

 echo $service_hash | sed '/\\/s///g ' | sed "/\"\[/s//\[/" | sed "/\]\"/s//\]/"  | /home/engines/bin/json_to_env >/tmp/.env
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

n=0
$array_cnt=${#publisher_namespace[@]}
while test $n -le $array_cnt
 do
 src_type=`basename $type_path[$n]`
 export src_type
  /home/add_backup.sh /$publisher_namespace[$n]/$type_path[$n]/$parent_engine[$n]/$service_handle[$n]/
  n=`expr $n + 1`
 done

 exit 0
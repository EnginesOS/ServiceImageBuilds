#!/bin/bash

service_hash=$1


echo $service_hash   | sed '/\"\[/s// \[/' | sed '/\\/s///g' | sed '/\]\"/s//\] /'| /home/engines/bin/json_to_env >/tmp/.env

 
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
parent=$parent_engine
export parent

n=0
array_cnt=${#publisher_namespace[@]}
echo $n $array_cnt
while test $n -lt $array_cnt
 do
 src_type=`basename ${type_path[n]}`
 echo $src_type

 
 export src_type
  /home/add_backup.sh ${parent_engine[n]}:${publisher_namespace[n]}/${type_path[n]}/${service_handle[n]}/
echo "PASSED  ${parent_engine[n]}:${publisher_namespace[n]}/${type_path[n]}/${service_handle[n]}/"
  n=`expr $n + 1`
 done

 exit 0
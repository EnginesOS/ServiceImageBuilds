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
export backup_type


if test $backup_up = 'engine_and_data'
 then
     /home/add_backup.sh ${parent_engine}:system
	n=0
	array_cnt=${#publisher_namespace[@]}
	echo $n $array_cnt
		while test $n -lt $array_cnt
 		 do
 			src_type=`basename ${type_path[n]}`
 			export src_type
  			/home/add_backup.sh ${parent_engine[n]}:${publisher_namespace[n]}/${type_path[n]}/${service_handle[n]}/
			echo "PASSED  ${parent_engine[n]}:${publisher_namespace[n]}/${type_path[n]}/${service_handle[n]}/"
  			n=`expr $n + 1`
 		done
  elif test $backup_up = 'engine_only'
  then
  /home/add_backup.sh ${parent_engine}:system
  else
    /home/add_backup.sh ${parent_engine}:${publisher_namespace}/${type_path}/${service_handle}/
fi
 exit 0
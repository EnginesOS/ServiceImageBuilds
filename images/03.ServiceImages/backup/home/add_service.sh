#!/bin/bash


 cat -  | /home/engines/bin/json_to_env  | sed "/sources='\[/s//sources\[/" | sed "/\]'/s//\]/" > /tmp/.env
 . /tmp/.env

echo $1 >/home/configurators/saved/backup_$parent_engine

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


if test $src_type = 'engine'
 then
     /home/add_backup.sh ${parent_engine}:system
	n=1
 curl http://172.17.0.1:2380/v0/backup/engine/services/${parent_engine} | /home/engines/bin/json_to_env >/tmp/.src
  . /tmp/.src
	service=`eval echo service$n`
		while ! test -z $service
 		 do
         /home/add_backup.sh `eval echo service$n`
         n=`expr $n + 1`
         service=`eval echo service$n`
 		done
 	/home/add_backup.sh config:${parent_engine}	
  elif test $backup_type = 'engine_only'
  then
  /home/add_backup.sh config:${parent_engine}
  else
    /home/add_backup.sh ${parent_engine}/service/${publisher_namespace}/${type_path}/${service_handle}
fi
 exit 0
#!/bin/sh


. /home/engines/functions/checks.sh
. /home/engines/scripts/engine/backup_dirs.sh
 
required_values="backup_name dest_folder dest_proto parent_engine backup_type src_type"
check_required_values

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
   /home/engines/scripts/engine/add_backup.sh ${parent_engine}:system
   n=1
   services=`curl -k https://172.17.0.1:2380/v0/backup/engine/services/${parent_engine}\
 | tr -d "\n\r" | sed "/,/s//\n/g"  | tr -d "{}\""  | cut -f2 -d:`
   
  for service in $services
 	 do
       /home/engines/scripts/engine/add_backup.sh $service
 	 done
 	/home/engines/scripts/engine/add_backup.sh config:${parent_engine}	
elif test $backup_type = 'engine_only'
  then
    /home/engines/scripts/engine/add_backup.sh config:${parent_engine}
else
   /home/engines/scripts/engine/add_backup.sh ${parent_engine}/service/${publisher_namespace}/${type_path}/${service_handle}
fi

 exit 0
 
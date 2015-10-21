#!/bin/bash


service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment
Backup_ConfigDir=/home/backup/.duply/
echo name $backup_name
echo parent_engine $parent_engine
echo src_type $src_type
dirname=${parent_engine}_${backup_name}_${src_type}
dirname=${Backup_ConfigDir}/$dirname

echo dirname $dirname

 echo "${dirname}: $*" >>/var/log/backup//rmbackup.log
if test -n $1
	then
		rm -rf $dirname
		 if test -f ${dirname}_fs
		 	then
		 		rm -rf ${dirname}_fs
		 fi
		 if test -f ${dirname}_db
		 	then
		 		rm -rf ${dirname}_db
		 fi		 
	fi

      
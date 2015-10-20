#!/bin/bash


service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment
dirname=$Backup_ConfigDir/$parent_engine_$name_$src_type

Backup_ConfigDir=/home/backup/.duply/
 echo "$*" >>/var/log/backup//rmbackup.log
if test -n $1
	then
		rm -r $dirname
		 if test -f ${dirname}_fs
		 	then
		 		rm ${dirname}_fs
		 fi
		 if test -f ${dirname}_db
		 	then
		 		rm ${dirname}_db
		 fi		 
	fi

      
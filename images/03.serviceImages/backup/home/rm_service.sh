#!/bin/bash


service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment


Backup_ConfigDir=/home/backup/.duply/
 echo "$*" >>/var/log/backup//rmbackup.log
if test -n $1
	then
		rm -r $Backup_ConfigDir/$1
	fi

      
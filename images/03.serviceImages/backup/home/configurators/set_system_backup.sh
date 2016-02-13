#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/system_backup


#. /home/engines/scripts/functions.sh

#load_service_hash_to_environment

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

 echo "$*" >>/var/log/backup/addbackup.log

Backup_ConfigDir=/home/backup/.duply/
export

if test -f /home/configurators/saved/default_destination
then

service_hash=`cat /home/configurators/saved/default_destination`
load_service_hash_to_environment
dest=$dest_proto://$dest_address/$dest_folder
user=$dest_user
pass=$dest_pass
if test $dest_proto = "s3"
	then	
		dest_proto="s3+http://"
	fi

				if test  $include_system = "true"
					then
						mkdir -p $Backup_ConfigDir/system
                		/home/prep_conf.sh $Backup_ConfigDir/system/conf
                		src=/backup_src/engines
                		echo "SOURCE='$src'" >>$Backup_ConfigDir/system/conf
_dest=$dest/system
echo "TARGET='$_dest'" >>$Backup_ConfigDir/system/conf
echo "TARGET_USER='$user'"  >>$Backup_ConfigDir/system/conf
echo "TARGET_PASS='$pass'"  >>$Backup_ConfigDir/system/conf
					fi
				if test  $include_databases = "true"
					then
						src=/home/backup/sql_dumps
						mkdir -p $Backup_ConfigDir/system_databases
						cat /home/tmpl/system_dumpall.sh >  $Backup_ConfigDir/system_databases/pre
                		cp /home/tmpl/dumpall_post.sh  $Backup_ConfigDir/system_databases/post
                		chmod u+x $Backup_ConfigDir/system_databases/pre
                		chmod u+x $Backup_ConfigDir/system_databases/pos
                		/home/prep_conf.sh $Backup_ConfigDir/system_databases/conf

                		echo "SOURCE='$src'" >>$Backup_ConfigDir/system_databases/conf
_dest=$dest/databases
echo "TARGET='$_dest'" >>$Backup_ConfigDir/system_databases/conf
echo "TARGET_USER='$user'"  >>$Backup_ConfigDir/system_databases/conf
echo "TARGET_PASS='$pass'"  >>$Backup_ConfigDir/system_databases/conf
				fi
				
				if test $include_logs = "true"
					then
						mkdir -p $Backup_ConfigDir/system_logs
						src=/backup_src/logs						
						/home/prep_conf.sh $Backup_ConfigDir/system_logs/conf
						echo "SOURCE='$src'" >>$Backup_ConfigDir/system_logs/conf
_dest=$dest/logs
echo "TARGET='$_dest'" >>$Backup_ConfigDir/system_logs/conf
echo "TARGET_USER='$user'"  >>$Backup_ConfigDir/system_logs/conf
echo "TARGET_PASS='$pass'"  >>$Backup_ConfigDir/system_logs/conf
				fi
				
				if test $include_files = "true"
					then
						mkdir -p $Backup_ConfigDir/system_files
						echo /backup_src/volumes/mysql >  $Backup_ConfigDir/system_files/exclude
						src=/backup_src/volumes/
						/home/prep_conf.sh  $Backup_ConfigDir/system_files/conf
						echo "SOURCE='$src'" >>$Backup_ConfigDir/system_files/conf
_dest=$dest/volumes				
echo "TARGET='$_dest'" >>$Backup_ConfigDir/system_files/conf
echo "TARGET_USER='$user'"  >>$Backup_ConfigDir/system_files/conf
echo "TARGET_PASS='$pass'"  >>$Backup_ConfigDir/system_files/conf
				fi
				

       exit 0

  fi

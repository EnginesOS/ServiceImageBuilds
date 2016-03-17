#!/bin/bash

function add_service {
/tmp/
src=/tmp/backup_$service/
						mkdir -p $Backup_ConfigDir/$service
						echo -n $service >$Backup_ConfigDir/$service/service
						 cp   /home/tmpl/service_pre.sh $Backup_ConfigDir/$service/pre
                		cp /home/tmpl/service_post.sh  $Backup_ConfigDir/$service/post
                		chmod u+x $Backup_ConfigDir/$service/pre
                		chmod u+x $Backup_ConfigDir/$service/post
                		/home/prep_conf.sh $Backup_ConfigDir/$service/conf

                		echo "SOURCE='$src'" >>$Backup_ConfigDir/$service/conf
_dest=$dest/databases
echo "TARGET='$_dest'" >>$Backup_ConfigDir/$service/conf
echo "TARGET_USER='$user'"  >>$Backup_ConfigDir/$service/conf
echo "TARGET_PASS='$pass'"  >>$Backup_ConfigDir/$service/conf
}
service_hash=$1

echo $1 >/home/configurators/saved/system_backup



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
                		cp /home/tmpl/system_prep.sh $Backup_ConfigDir/system/pre
                		cp /home/tmpl/system_post.sh  $Backup_ConfigDir/system/post
                		mkdir -p /tmp/system_backup
 						src=/tmp/system_backup
                		echo "SOURCE='$src'" >>$Backup_ConfigDir/system/conf
                	
_dest=$dest/system
echo "TARGET='$_dest'" >>$Backup_ConfigDir/system/conf
echo "TARGET_USER='$user'"  >>$Backup_ConfigDir/system/conf
echo "TARGET_PASS='$pass'"  >>$Backup_ConfigDir/system/conf

					fi
				if test  $include_services = "true"
					then
						for service in $services
						 do
						 if test $service = 'filesystem' -o $service = 'syslog'
						  then
						  continure
						  fi 
							add_service 
						done	
						
				fi
				
				if test $include_logs = "true"
					then
					service=syslog
					add_service 
				fi
				
				if test $include_files = "true"
					then
					service=volmanager
						add_service 
				fi
				

       exit 0

  fi

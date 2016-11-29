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

cat - > /home/configurators/saved/system_backup
cat  /home/configurators/saved/system_backup | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

cat home/configurators/saved/system_backup >>/var/log/backup/addbackup.log

Backup_ConfigDir=/home/backup/.duply/
export

if test -f /home/configurators/saved/default_destination
then

cat /home/configurators/saved/default_destination | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

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
                		cp /home/tmpl/system_pre.sh $Backup_ConfigDir/system/pre
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
					services=`grep -lr backup_support /opt/engines/etc/services/providers/ |uniq |sed "/\.yaml/s///"`
						for service_path in $services						
						 do
						 service=`basename $service_path `
						 if test $service = 'filesystem' -o $service = 'syslog'
						  then
						  continue
						  fi 
							add_service 
						done	
						
				fi
				
				if test $include_logs = "true"
					then
					mkdir -p $Backup_ConfigDir/logs
					/home/prep_conf.sh $Backup_ConfigDir/logs/conf
					echo "SOURCE=/backup_src/logs/" >>$Backup_ConfigDir/logs/conf
				fi
				
				if test $include_files = "true"
					then
					service=volmanager
						add_service 
				fi
				

       exit 0

  fi

#!/bin/bash

function add_service {
src=/tmp/backup_$service/

mkdir -p ${Backup_ConfigDir}/${service}
chmod og-r $Backup_ConfigDir/$service
echo -n $service >$Backup_ConfigDir/$service/service
cp /home/tmpl/service_pre.sh $Backup_ConfigDir/$service/pre
cp /home/tmpl/service_post.sh  $Backup_ConfigDir/$service/post
chmod u+x $Backup_ConfigDir/$service/pre
chmod u+x $Backup_ConfigDir/$service/post
/home/prep_conf.sh $Backup_ConfigDir/$service/conf

echo "SOURCE='$src'" >>$Backup_ConfigDir/$service/conf
_dest=$dest/$service
echo "TARGET='$_dest'" >>$Backup_ConfigDir/$service/conf
echo "TARGET_USER='$user'"  >>$Backup_ConfigDir/$service/conf
echo "TARGET_PASS='$pass'"  >>$Backup_ConfigDir/$service/conf
}

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/configurators/saved/system_backup
parms_to_file_and_env

cat home/configurators/saved/system_backup >>/var/log/backup/addbackup.log

Backup_ConfigDir=/home/backup/.duply/

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
     chmod og-r $Backup_ConfigDir/system
     /home/prep_conf.sh $Backup_ConfigDir/system/conf
     cp /home/tmpl/system_pre.sh $Backup_ConfigDir/system/pre
     cp /home/tmpl/system_post.sh $Backup_ConfigDir/system/post
     mkdir -p /tmp/system_backup
     src=/tmp/system_backup
     echo "SOURCE='$src'" >> $Backup_ConfigDir/system/conf           	
     _dest=$dest/system
     echo "TARGET='$_dest'" >> $Backup_ConfigDir/system/conf
     echo "TARGET_USER='$user'" >> $Backup_ConfigDir/system/conf
     echo "TARGET_PASS='$pass'" >> $Backup_ConfigDir/system/conf
     
    service=registry
  	add_service
  fi
  
  if test  $include_services = "true"
    then
      services=`grep -lr backup_support /opt/engines/etc/services/providers/ |uniq`
        for service_path in $services						
          do
  		  service=`grep service_container $service_path | awk -F : '{print $2}' | sed "/ /s///g" `
  		  if test -z $service
  		   then
  		     echo "FAILED to get service for $service_path"
  		     continue
  		   fi
  			if test $service = 'filesystem' 
  			  then
  				 continue
  			 fi 
  			echo ADD SERVICE $service
  			add_service 
  		done	  						

  fi
  				
  if test $include_logs = "true"
    then
      mkdir -p $Backup_ConfigDir/logs
      chmod og-r $Backup_ConfigDir/logs
      /home/prep_conf.sh $Backup_ConfigDir/logs/conf
      _dest=$dest/logs
      echo "TARGET='$_dest'" >>$Backup_ConfigDir/logs/conf
      echo "TARGET_USER='$user'"  >>$Backup_ConfigDir/logs/conf
      echo "TARGET_PASS='$pass'"  >>$Backup_ConfigDir/logs/conf
      echo "SOURCE=/backup_src/logs/" >>$Backup_ConfigDir/logs/conf
  fi
  				
  if test $include_files = "true"
    then
    echo -n incr > $Backup_ConfigDir/engines_fs/backup_type
    mkdir -p $Backup_ConfigDir/engines_fs
  	chmod og-r $Backup_ConfigDir/engines_fs
  	/home/prep_conf.sh $Backup_ConfigDir/engines_fs/conf
  	_dest=$dest/engines_files
  	echo "TARGET='$_dest'" >>$Backup_ConfigDir/engines_fs/conf
  	echo "TARGET_USER='$user'" >>$Backup_ConfigDir/engines_fs/conf
  	echo "TARGET_PASS='$pass'" >>$Backup_ConfigDir/engines_fs/conf
  	echo "SOURCE=/backup_src/volumes/fs/" >>$Backup_ConfigDir/engines_fs/conf
  fi
 exit 0
fi

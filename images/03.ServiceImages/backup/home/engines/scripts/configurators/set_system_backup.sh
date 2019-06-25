#!/bin/sh

. /home/engines/scripts/engine/backup_functions.sh
. /home/engines/scripts/engine/backup_dirs.sh

if ! test -f /home/engines/scripts/configurators/saved/default_destination/settings
 then
  save_system_settings
  echo '{"status:"warning","message":"please set backup default destination"}'
  exit 1 
fi

. /home/engines/scripts/configurators/saved/default_destination/settings

 if test -f /home/engines/scripts/configurators/saved/backup_email
  then
    . /home/engines/scripts/configurators/saved/backup_email
  else
    save_system_settings
    echo '{"status:"warning","message":"please set backup notification email"}'
    exit 1
fi
. /home/engines/scripts/engine/backup_dirs.sh

cat /home/engines/scripts/configurators/saved/system_backup  >>/var/log/backup/addbackup.log


if test -d /home/engines/scripts/configurators/saved/default_destination
 then
  . /home/engines/scripts/configurators/saved/default_destination/settings

    if test "$1" = rebuild
     then
 		. /home/engines/scripts/configurators/saved/system_backup/settings 
     else
       save_system_settings
     fi
  
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
     chmod og-rx $Backup_ConfigDir/system
     /home/engines/scripts/services/prep_conf.sh $Backup_ConfigDir/system/conf
     cp /home/engines/templates/backup/system_pre.sh $Backup_ConfigDir/system/pre
     cp /home/engines/templates/backup/system_post.sh $Backup_ConfigDir/system/post
     mkdir -p /tmp/system_backup
     src=/tmp/system_backup
     echo "SOURCE=$src" > $Backup_ConfigDir/system/conf           	
     _dest=$dest/system
     echo "TARGET=$_dest" >> $Backup_ConfigDir/system/conf
     echo "TARGET_USER="'"$user"'" >> $Backup_ConfigDir/system/conf
     echo "TARGET_PASS="'"$pass"'" >> $Backup_ConfigDir/system/conf
     
    service=registry
  	add_service
  fi
  
  if test $include_services = "true"
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
  			 if test $service = 'volmgr' 
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
      chmod og-rx $Backup_ConfigDir/logs
      /home/engines/scripts/services/prep_conf.sh $Backup_ConfigDir/logs/conf
      _dest=$dest/logs
      echo "TARGET='$_dest'" >>$Backup_ConfigDir/logs/conf
      echo "TARGET_USER='$user'" >>$Backup_ConfigDir/logs/conf
      echo "TARGET_PASS='$pass'" >>$Backup_ConfigDir/logs/conf
      echo "SOURCE=/backup_src/logs/" >>$Backup_ConfigDir/logs/conf
  fi
  				
  if test $include_files = "true"
    then
    echo -n incr > $Backup_ConfigDir/engines_fs/backup_type
    mkdir -p $Backup_ConfigDir/engines_fs
  	chmod og-rx $Backup_ConfigDir/engines_fs
  	/home/engines/scripts/services/prep_conf.sh $Backup_ConfigDir/engines_fs/conf
  	_dest=$dest/engines_files
  	echo "TARGET='$_dest'" >>$Backup_ConfigDir/engines_fs/conf
  	echo "TARGET_USER='$user'" >>$Backup_ConfigDir/engines_fs/conf
  	echo "TARGET_PASS='$pass'" >>$Backup_ConfigDir/engines_fs/conf
  	echo "SOURCE=/backup_src/volumes/fs/" >>$Backup_ConfigDir/engines_fs/conf
  fi
 exit 0
fi

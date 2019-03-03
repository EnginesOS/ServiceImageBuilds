#!/bin/bash
. /home/engines/scripts/engine/backup_dirs.sh
function add_service {
src=/tmp/backup_$service/

mkdir -p ${Backup_ConfigDir}/${service}
chmod og-rx $Backup_ConfigDir/$service
echo -n $service >$Backup_ConfigDir/$service/service
cp /home/engines/templates/backupservice_pre.sh $Backup_ConfigDir/$service/pre
cp /home/engines/templates/backupservice_post.sh  $Backup_ConfigDir/$service/post
chmod u+x $Backup_ConfigDir/$service/pre
chmod u+x $Backup_ConfigDir/$service/post
/home/engines/scripts/services/prep_conf.sh $Backup_ConfigDir/$service/conf

echo "SOURCE='$src'" >>$Backup_ConfigDir/$service/conf
_dest=$dest/$service
echo "TARGET='$_dest'" >>$Backup_ConfigDir/$service/conf
echo "TARGET_USER='$user'"  >>$Backup_ConfigDir/$service/conf
echo "TARGET_PASS='$pass'"  >>$Backup_ConfigDir/$service/conf
}


cat /home/engines/scripts/configurators/saved/system_backup >>/var/log/backup/addbackup.log

Backup_ConfigDir=/home/backup/.duply/

if test -d /home/engines/scripts/configurators/saved/default_destination
 then
  . /home/engines/scripts/configurators/saved/default_destination/settings

    if test "$1" = rebuild
     then
 		. /home/engines/scripts/configurators/saved/system_backup/settings    
     else
       mkdir -p /home/engines/scripts/configurators/saved/system_backup
       echo include_logs=$include_logs > /home/engines/scripts/configurators/saved/system_backup/settings
      echo include_files=$include_files >> /home/engines/scripts/configurators/saved/system_backup/settings
      echo include_services=$include_services >> /home/engines/scripts/configurators/saved/system_backup/settings
      echo include_system=$include_system >> /home/engines/scripts/configurators/saved/system_backup/settings
      echo frequency=$frequency >> /home/engines/scripts/configurators/saved/system_backup/settings    
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
     cp /home/engines/templates/backupsystem_pre.sh $Backup_ConfigDir/system/pre
     cp /home/engines/templates/backupsystem_post.sh $Backup_ConfigDir/system/post
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

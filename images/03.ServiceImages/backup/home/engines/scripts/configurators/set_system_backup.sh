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

if ! test -d /home/engines/scripts/configurators/saved/default_destination
 then
 	save_system_settings
    echo '{"status:"warning","message":"please set backup default settings"}'
    exit 1
 else
  . /home/engines/scripts/configurators/saved/default_destination/settings

    if test "$1" = rebuild
     then
 		. /home/engines/scripts/configurators/saved/system_backup/settings 
     else
       save_system_settings
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
     backup_id=system     
	 write_duply_config
    service=registry
    export service
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
  			add_service 
  		done	  						
  fi
  				
  if test $include_logs = "true"
    then
      mkdir -p $Backup_ConfigDir/logs
      chmod og-rx $Backup_ConfigDir/logs
      /home/engines/scripts/services/prep_conf.sh $Backup_ConfigDir/logs/conf
      src=/backup_src/logs
      _dest=$dest/logs
	  backup_id=logs
      write_duply_config
  fi
  				
  if test $include_files = "true"
    then
    echo -n incr > $Backup_ConfigDir/engines_fs/backup_type
    mkdir -p $Backup_ConfigDir/engines_fs
  	chmod og-rx $Backup_ConfigDir/engines_fs
  	/home/engines/scripts/services/prep_conf.sh $Backup_ConfigDir/engines_fs/conf
  	_dest=$dest/engines_files
    src=/backup_src/volumes/
  	backup_id=engines_fs
	write_duply_config
  fi
 exit 0
fi

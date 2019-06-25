#!/bin/sh


  
mkdir -p /home/engines/scripts/configurators/saved/default_destination

  echo "dest_address=$dest_address
   	    dest_folder=$dest_folder
        dest_pass='"'$dest_pass'"' 
        dest_proto=$dest_proto 
        dest_user=$dest_user" > /home/engines/scripts/configurators/saved/default_destination/settings
        
if ! test -f /home/backup/.gnupg/key_created
 then
  echo "Please set backup notification "
  exit 0
fi
if test -f /home/engines/scripts/configurators/saved/system_backup
 then
    . /home/engines/scripts/configurators/saved/system_backup/settings
 	/home/engines/scripts/configurators/set_system_backup.sh 
fi


exit 0

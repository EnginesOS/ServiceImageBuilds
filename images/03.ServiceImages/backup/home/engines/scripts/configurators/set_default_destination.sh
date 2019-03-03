#!/bin/sh

mkdir -p /home/engines/scripts/configurators/saved/default_destination

  echo dest_address=$dest_address > /home/engines/scripts/configurators/saved/default_destination/settings
  echo dest_folder=$dest_folder >> /home/engines/scripts/configurators/saved/default_destination/settings
  echo dest_pass=$dest_folder >> /home/engines/scripts/configurators/saved/default_destination/settings
  echo dest_proto=$dest_folder >> /home/engines/scripts/configurators/saved/default_destination/settings
  echo dest_user=$dest_folder  >> /home/engines/scripts/configurators/saved/default_destination/settings
  
if test -f /home/engines/scripts/configurators/saved/system_backup
 then
 	/home/engines/scripts/configurators/set_system_backup.sh 
fi


exit 0

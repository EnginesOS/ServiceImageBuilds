#!/bin/sh

mkdir -p /home/engines/scripts/configurators/saved/default_destination
echo -n $dest_pass > /home/engines/scripts/configurators/saved/default_destination/dest_pass
echo -n $dest_proto > /home/engines/scripts/configurators/saved/default_destination/dest_proto
echo -n $dest_address > /home/engines/scripts/configurators/saved/default_destination/dest_address
echo -n $dest_user > /home/engines/scripts/configurators/saved/default_destination/dest_user
echo -n $dest_folder > /home/engines/scripts/configurators/saved/default_destination/dest_folder


if test -f /home/engines/scripts/configurators/saved/system_backup
 then
 	/home/engines/scripts/configurators/set_system_backup.sh 
fi


exit 0

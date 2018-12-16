#!/bin/sh


echo -n $backup_email >/home/engines/scripts/configurators/saved/backup_email

if ! test -f /home/backup/.gnupg/key_created
 then
   /home/engines/scripts/configurators/init_gpg_key.sh
fi

if test -f /home/engines/scripts/configurators/saved/system_backup
 then
 	/home/engines/scripts/configurators/set_system_backup.sh 
fi


exit 0
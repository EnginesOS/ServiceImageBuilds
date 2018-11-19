#!/bin/sh


echo -n $backup_email >/home/engines/scripts/configurators/saved/backup_email

if ! test -f /home/backup/.gnupg/key_created
 then
   /home/engines/scripts/configurators/init_gpg_key.sh
fi

exit 0
#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/configurators/saved/backup_email_hash
parms_to_file_and_env

echo -n $backup_email >/home/configurators/saved/backup_email

if ! test -f /home/backup/.gnupg/key_created
 then
   /home/configurators/init_gpg_key.sh
fi

exit 0
#!/bin/bash

service_hash=$1


echo $1 >/home/configurators/saved/backup_email_hash

. /home/engines/scripts/functions.sh

load_service_hash_to_environment



echo $backup_email >/home/configurators/saved/backup_email

if ! test -f /home/backup/.gnupg/key_created
	then
		/home/configurators/init_gpg_key.sh
	fi


exit 0
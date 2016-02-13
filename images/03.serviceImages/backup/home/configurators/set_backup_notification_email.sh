#!/bin/bash

service_hash=$1


echo $1 >/home/configurators/saved/backup_email_hash




 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env


echo $backup_email >/home/configurators/saved/backup_email

if ! test -f /home/backup/.gnupg/key_created
	then
		/home/configurators/init_gpg_key.sh
	fi


exit 0
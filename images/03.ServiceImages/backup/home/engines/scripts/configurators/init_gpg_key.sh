#!/bin/sh
if ! test -f /home/backup/.gnupg/pass
 then 
 	mkdir /home/backup/.gnupg/
 	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 7 | head -n 1 >/home/backup/.gnupg/pass
	pass=`cat /home/backup/.gnupg/pass`
	email=`cat /home/engines/scripts/configurators/saved/backup_email`

 	if test -z $email
 	then
 		exit 
 	fi
 	
	cat /home/engines/templates/backupkey.tmpl | sed "/EMAIL/s//$email/" | sed "/PASS/s//$pass/" > /tmp/key.tmpl
 	gpg --gen-key --batch /tmp/key.tmpl
 	rm /tmp/key.tmpl
   
	gpg --list-keys  |grep 1024D | tail -1 | cut -f2 -d/ |cut -f1 -d" " > /home/backup/.gnupg/key_id
	key_id=`cat /home/backup/.gnupg/key_id`
    cp /home/backup/.gnupg/pass /home/backup/.gnupg/pass_${key_id}
    chmod og-wxr /home/backup/.gnupg/pass /home/backup/.gnupg/pass_${key_id}
	touch /home/backup/.gnupg/key_created
fi
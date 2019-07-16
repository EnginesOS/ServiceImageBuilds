#!/bin/sh
sudo  /home/engines/scripts/actionators/sudo/_fix_perms.sh

if ! test -f /home/backup/.gnupg/pass
 then 
 	mkdir /home/backup/.gnupg/
 	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 7 | head -n 1 >/home/backup/.gnupg/pass
	pass=`cat /home/backup/.gnupg/pass`
	if test -f /home/engines/scripts/configurators/saved/backup_email
     then
      . /home/engines/scripts/configurators/saved/backup_email
    fi  

 	if test -z $backup_reports_email
 	then
 		exit 
 	fi
 	
	cat /home/engines/templates/backup/backupkey.tmpl | sed "/EMAIL/s//$backup_reports_email/" | sed "/PASS/s//$pass/" > /tmp/key.tmpl
 	gpg --gen-key --batch /tmp/key.tmpl
 	rm /tmp/key.tmpl
   
	gpg --list-keys  |grep -1 dsa1024 | tail -1 | sed "/[ ]/s///g" > /home/backup/.gnupg/key_id
	key_id=`cat /home/backup/.gnupg/key_id`
    cp /home/backup/.gnupg/pass /home/backup/.gnupg/pass_${key_id}
    chmod og-wxr /home/backup/.gnupg/pass /home/backup/.gnupg/pass_${key_id}
	touch /home/backup/.gnupg/key_created
fi

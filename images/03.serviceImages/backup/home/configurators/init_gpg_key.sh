#!/bin/sh
 cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 7 | head -n 1 >/home/backup/.gnupg/pass
pass=`cat /home/backup/.gnupg/pass`
email=`cat /home/configurators/saved/backup_email`
cat /home/tmpl/key.tmpl | sed "/EMAIL/s//$email/" | sed "/PASS/s//$pass/" > /tmp/key.tmpl
 gpg --gen-key --batch /tmp/key.tmpl
 rm /tmp/key.tmpl
 
gpg --list-keys  |grep 1024D | cut -f2 -d/ |cut -f1 -d" " > /home/backup/.gnupg/key_id

touch /home/backup/.gnupg/key_created

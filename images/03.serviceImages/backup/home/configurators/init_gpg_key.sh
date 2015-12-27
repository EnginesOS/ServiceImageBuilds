#!/bin/sh
email=`cat /home/configurators/saved/backup_email`
cat /home/tmpl/key.tmpl | sed "/EMAIL/s//$email/" > /tmp/key.tmpl
 gpg --gen-key --batch /tmp/key.tmpl
 rm /tmp/key.tmpl
 
gpg --list-keys  |grep 1024D | cut -f2 -d/ |cut -f1 -d" " > /home/backup/.gnupg/key_id

touch /home/backup/.gnupg/key_created
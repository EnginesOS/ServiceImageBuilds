#!/bin/bash

cd /
tar -xpf - 2>/tmp/tar.errs
tar -xzpf /tmp/imap/backup.*gz /var/lib/dovecot /tmp/database.sql /var/mail

cat /tmp/database.sql |mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 
r=$?

rm /tmp/database.sql /tmp/imap/backup.*gz 

exit $? 

#!/bin/bash

cd /
tar -xpf - 2>/tmp/tar.errs
tar -xpf /tmp/imap/backup.* /var/lib/dovecot /tmp/database.sql /var/mail

cat /tmp/database.sql |mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 
r=$?

rm /tmp/database.sql /tmp/imap/backup.*

exit $? 

#!/bin/bash

cd /
tar -xzpf - 2>/tmp/tar.errs
tar -xzpf /tmp/imap/backup.*gz /var/lib/dovecot /tmp/database.sql /var/mail

cat /tmp/database.sql |mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 

rm /tmp/database.sql 

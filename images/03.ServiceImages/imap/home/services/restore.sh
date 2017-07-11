#!/bin/bash


cd /

cat - | tar -xzpf - /var/lib/dovecot /tmp/database.sql  /var/mail

cat /tmp/database.sql |mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 

rm /tmp/database.sql 

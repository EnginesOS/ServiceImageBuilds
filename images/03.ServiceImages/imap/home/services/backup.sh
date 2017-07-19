#!/bin/bash


mysqldump -h $dbhost -u $dbuser --password=$dbpasswd $dbname > /tmp/database.sql 
tar -cpf - /var/lib/dovecot /tmp/database.sql  /var/mail 
rm /tmp/database.sql 

#!/bin/sh

cd /etc/dkim/keys/
rm /etc/opendkim/KeyTable /etc/opendkim/SigningTable 
touch /etc/opendkim/KeyTable /etc/opendkim/SigningTable 

for domain in `ls `
 do 
 	echo '*@'$domain:$domain:/etc/mail/dkim-keys/$domain/mail.private >>  /etc/opendkim/KeyTable
 	echo '*@'$domain default._domainkey.$domain >> /etc/opendkim/SigningTable 
 done
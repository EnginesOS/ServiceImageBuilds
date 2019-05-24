#!/bin/sh

cd /etc/opendkim/keys/
rm /etc/opendkim/KeyTable /etc/opendkim/SigningTable 
touch /etc/opendkim/KeyTable /etc/opendkim/SigningTable 

for domain in `ls `
 do 
 	echo default._domainkey.$domain $domain:default:/etc/opendkim/keys/$domain/mail.private >> /etc/opendkim/KeyTable
 	echo '*@'$domain default._domainkey.$domain >> /etc/opendkim/SigningTable 
 done
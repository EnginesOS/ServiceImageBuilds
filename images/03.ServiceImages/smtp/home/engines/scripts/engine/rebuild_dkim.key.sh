#!/bin/sh

cd /etc/dkim/keys/
rm /etc/dkim/dkim.key
touch /etc/dkim/dkim.key

for domain in `ls `
 do 
 	echo '*@'$domain:$domain:/etc/mail/dkim-keys/$domain/dt.private >>  /etc/dkim/dkim.key
 done
#!/bin/sh
cp -rp /tmp/spool_postfix/* /var/spool/postfix
rm -r /tmp/spool_postfix/
postfix set-permissions
chown postfix  /home/engines/scripts/configurators/saved/ 

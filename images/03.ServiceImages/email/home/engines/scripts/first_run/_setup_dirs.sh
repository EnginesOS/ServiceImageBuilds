#!/bin/sh
cp -rp /tmp/spool_postfix/* /var/spool/postfix
rm -r /tmp/spool_postfix/
postfix set-permissions

chown postfix  /home/engines/scripts/configurators/saved/

if ! test -d  /etc/postfix/maps/aliases/
 then
   mkdir /etc/postfix/maps/aliases/
    touch /etc/postfix/maps/aliases/aliases    
fi
mkdir -p /var/spool/postfix/pid/

chown postfix /var/spool/postfix/pid/

chown postfix /etc/postfix/maps/aliases/
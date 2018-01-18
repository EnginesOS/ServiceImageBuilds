#!/bin/sh
 
if ! test -d  /etc/postfix/maps/aliases/
 then
   mkdir -p /etc/postfix/maps/aliases/
   touch /etc/postfix/maps/aliases/aliases
fi
chown -R postfix /etc/postfix/maps/

postfix set-permissions

chown postfix  /home/engines/scripts/configurators/saved/ 
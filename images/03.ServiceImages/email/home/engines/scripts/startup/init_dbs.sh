#!/bin/bash

for map_file in transport generic smarthost_passwd 
 do 
  if ! test -f /etc/postfix/${map_file}.db
   then
    sudo -n /home/engines/scripts/engine/_postmap.sh ${map_file}
  fi  
 done
 
if ! test -d  /etc/postfix/maps/aliases/
 then
   mkdir /etc/postfix/maps/aliases/
fi

if ! test -f /etc/postfix/maps/aliases/aliases
   then
    touch /etc/postfix/maps/aliases/aliases
fi

sudo -n /home/engines/scripts/engine/_postmap.sh aliases/aliases

chown postfix /etc/postfix/maps/aliases/


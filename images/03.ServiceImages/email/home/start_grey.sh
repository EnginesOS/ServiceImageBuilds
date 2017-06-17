#!/bin/bash


if test -f /home/configurators/grey/grey_list_delay
 then
   grey_list_delay=`cat /home/configurators/grey/grey_list_delay`
else
   grey_list_delay=120
fi
 
if test -z $grey_list_delay
 then
 	grey_list_delay=120
fi
 
if ! test -f /home/configurators/grey/white_clients
 then
   touch /home/configurators/grey/white_clients
fi

if ! test -f /home/configurators/grey/white_adresses
 then
   touch /home/configurators/grey/white_adresses
fi
 
sudo /usr/sbin/postgrey -d \
 --inet 127.0.0.1:60000 \
 --pidfile=/var/run/engines/grey.pid \
 --delay=${grey_list_delay} \
 --whitelist-clients=/home/configurators/grey/white_clients \
 --whitelist-recipients=/home/configurators/grey/white_adresses
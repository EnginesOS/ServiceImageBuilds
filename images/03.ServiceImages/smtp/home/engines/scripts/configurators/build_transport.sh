#!/bin/sh

if test -f /home/postfix/transport.smart
 then
   cp /home/postfix/transport.smart /home/postfix/transport
 else
  rm  /home/postfix/transport
fi  

if test -f /home/engines/scripts/configurators/saved/deliver_local
 then
  if test -f /home/engines/scripts/configurators/saved/domain
   then
    domain_name=`cat /home/engines/scripts/configurators/saved/domain`   
    echo "[$domain_name] :email.engines.internal" >> /home/postfix/transport
  fi
fi
    
if test -f /home/postfix/transport.over_ride
 then
  cat /home/postfix/transport.over_ride >> /home/postfix/transport
fi 

sudo -n /home/engines/scripts/engine/sudo/_postmap.sh transport

exit 0

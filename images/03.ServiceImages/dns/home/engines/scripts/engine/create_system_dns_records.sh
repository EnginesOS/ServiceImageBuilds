#!/bin/sh
. /home/engines/scripts/services/dns_functions.sh

if test -f /home/engines/system/net/ip
 then
  hostname=lanhost
  ip=`cat  /home/engines/system/net/ip`
  no_inarpra=1
  add_to_internal_domain
fi

if test -f /home/engines/system/net/public
 then
  ip=`cat /home/engines/system/net/public`
  hostname=publichost
  no_inarpra=1
  add_to_internal_domain
fi  



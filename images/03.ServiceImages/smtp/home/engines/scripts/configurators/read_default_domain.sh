#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/deliver_local
 then
  deliver_local=true
  #`cat /home/engines/scripts/configurators/saved/deliver_local`
  else
    deliver_local=false
fi  
 
if test -f /home/engines/scripts/configurators/saved/domain
 then
    domain_name=`cat /home/engines/scripts/configurators/saved/domain`   
	echo '{"domain_name":"'$domain_name'","delivery_local":"'$deliver_local'"}'
else
	echo '{"domain_name":"Not Set","delivery_local":"false"}'
fi
exit 0


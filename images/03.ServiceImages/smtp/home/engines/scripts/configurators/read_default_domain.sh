#!/bin/bash

if test -f /home/engines/scripts/configurators/saved/deliver_local
 then
  deliver_local=`cat /home/engines/scripts/configurators/saved/deliver_local`
  else
    deliver_local=false
fi  
 
if test -f /home/engines/scripts/configurators/saved/domain
 then
    domain_name=`cat /home/engines/scripts/configurators/saved/domain`   
	echo '{"default_domain":"'$domain_name'","delivery_local":"'$deliver_local'"}'
else
	echo '{"default_domain":"Not Set","delivery_local":"false"}'
fi
exit 0
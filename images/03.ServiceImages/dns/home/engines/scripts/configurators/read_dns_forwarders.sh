#!/bin/sh


 echo '{"forwarders":'["'
 
if test -f /home/engines/scripts/configurators/saved/dns_forwarder1
 then 
   dns_forwarder1=`cat home/engines/scripts/configurators/saved/dns_forwarder1`
  if test -f /home/engines/scripts/configurators/saved/dns_forwarder2
   then
    dns_forwarder1=`cat home/engines/scripts/configurators/saved/dns_forwarder2`
  fi
  
  if ! test -z $dns_forwarder1
   then
    echo $dns_forwarder1'"'
  fi
   
  if ! test -z $dns_forwarder1
   then
    echo ',"'$dns_forwarder2'"'
  fi
 
 echo ']}'

else
	echo '{"forwarders":[]}'
fi
exit 0

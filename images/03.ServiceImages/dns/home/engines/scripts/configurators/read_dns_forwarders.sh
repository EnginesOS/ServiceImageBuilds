#!/bin/sh

 echo '{'

if test -f /home/engines/scripts/configurators/saved/dns_forwarder1
 then
   dns_forwarder1=`cat home/engines/scripts/configurators/saved/dns_forwarder1`

  if test -f /home/engines/scripts/configurators/saved/dns_forwarder2
   then
    dns_forwarder2=`cat home/engines/scripts/configurators/saved/dns_forwarder2`
  fi
fi
  if ! test -z $dns_forwarder1
   then
    echo '"dns_server":"'$dns_forwarder1'"'
  fi

  if ! test -z $dns_forwarder1
   then
    echo ':"dns_server2":"'$dns_forwarder2'"'
  fi

        echo '}'

exit 0
~            
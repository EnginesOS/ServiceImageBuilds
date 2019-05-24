#!/bin/bash


 if test -z $dns_server
  then
   $dns_server=" "
 fi

if test ${#dns_server} -ge 7
 then
  echo  -n ${dns_server} >/home/engines/scripts/configurators/saved/dns_forwarder1
if test ${#dns_server2} -ge 7
  then
  echo  -n ${dns_server2} >> /home/engines/scripts/configurators/saved/dns_forwarder2
 else
  if test -f /home/engines/scripts/configurators/saved/dns_forwarder2
  then
  rm /home/engines/scripts/configurators/saved/dns_forwarder2
 fi
 fi
   echo "forwarders {
        $dns_server; " > /home/bind/engines/forwarders

    if ! test -z $dns_server2
     then
       if test ${#dns_server2} -ge 7
        then
         echo " $dns_server2; " >> /home/bind/engines/forwarders
        fi
    fi
  echo "}; " >> /home/bind/engines/forwarders
  else
    echo "Clearing forwarders"
   echo "" > /home/bind/engines/forwarders
fi

echo Success
exit 0
 
#!/bin/sh


 if test -z $dns_server
  then
   $dns_server=" "
 fi 
 
if test ${#dns_server} -ge 7
 then
  echo  dns_server=${#dns_server} >/home/engines/scripts/configurators/saved/dns_forwarders
  echo  dns_server2=${#dns_server2} >> /home/engines/scripts/configurators/saved/dns_forwarders
   echo "forwarders {
	$dns_server; " > /home/bind/engines/forwarders

    if ! test -z $dns_server2
     then
       if test ${#dns_server2} -ge 7
        then
         echo "	$dns_server2; " >> /home/bind/engines/forwarders
        fi 
    fi 
  echo "}; " >> /home/bind/engines/forwarders
  else
    echo "Clearing forwarders"
   echo "" > /home/bind/engines/forwarders 
fi
  
echo Success
exit 0
 
#!/bin/bash

cat - > /home/configurators/saved/dns_forwarders

 echo /home/configurators/saved/dns_forwarders | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

 
 if test -z $dns_server
 then
   echo "dns_server not set"
   echo "" > /home/bind/engines/forwarders
 	exit 127
 fi
 
echo "forwarders {
	$dns_server; " > /home/bind/engines/forwarders

 if ! test -z $dns_server2
  then
    echo "	$dns_server2; " >> /home/bind/engines/forwarders
 fi
 
echo "}; " >> /home/bind/engines/forwarders
  
echo Success
exit 0
 
 


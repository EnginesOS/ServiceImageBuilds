#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/dns_forwarders
parms_to_file_and_env

 
if test -z $dns_server
 then
   echo "Clearing forwarders"
   echo "" > /home/bind/engines/forwarders
else 
   echo "forwarders {
	$dns_server; " > /home/bind/engines/forwarders

    if ! test -z $dns_server2
     then
       echo "	$dns_server2; " >> /home/bind/engines/forwarders
    fi 
  echo "}; " >> /home/bind/engines/forwarders
fi
  
echo Success
exit 0
 
#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/dns_forwarders
parms_to_file_and_env

 if test -z $dns_server
  then
   $dns_server=" "
 fi 
 
if test ${#dns_server} -ge 7
 then 
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
 
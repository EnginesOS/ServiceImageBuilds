#!/bin/bash

service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

if test -z $fqdn
 then
 	echo "Error:no FQDN in nginx service hash"
 	exit -1
 fi
 
 if test -z $port
 then
 	echo "Error:no port in nginx service hash"
 	exit -1
 fi
  if test -z $proto
 then
 	echo "Error:no proto in nginx service hash"
 	exit -1
 fi
 
   if test -z $name
 then
 	echo "Error:no name in nginx service hash"
 	exit -1
 fi

	if test -f /etc/nginx/sites-enabled/${proto}_${fqdn}.site
	 then
	 	rm /etc/nginx/sites-enabled/${proto}_${fqdn}.site	 
	 	kill -HUP `cat /var/run/nginx/nginx.pid`
	else
		echo Warning:config /etc/nginx/sites-enabled/${proto}_${fqdn}.site not found
		exit 0
	fi
	 
	 echo Success
	 
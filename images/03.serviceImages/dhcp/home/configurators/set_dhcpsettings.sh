#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/dhcpsettings

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

if test -z $domain_name
 then
 	echo "domain_name not set"
 	exit 127
 fi
 if test -z  $netmask
   echo "netmask not set"
 	exit 127
 fi
 
 if test -z $subnet 
   echo "subnet not set"
 	exit 127
 fi
 
 if test -z $start
   echo "start not set"
 	exit 127
 fi
 
 if test -z $end
   echo "end not set"
 	exit 127
 fi

 if test -z $default_gateway
   echo "default_gateway not set"
 	exit 127
 fi
 
 if test -z $dns_server1
   echo "dns_server1 not set"
 	exit 127
 fi

$dns_server2
$default_lease
$max_lease





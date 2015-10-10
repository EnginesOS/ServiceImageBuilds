#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/dhcpd_settings

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
 
 if test -z $end$
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

 if test -z $dns_server2
  then
    $dns_server=8.8.8.8
 fi
 
 if test -z $default_lease
  then
  	$default_lease=3600
 fi
 
if test -z $max_lease
  then
  	$max_lease=36000
fi

cat /home/dhcpd.conf.tmpl |sed "/DOMAIN_NAME/s//$domain_name/" \
							"/ENGINES_IP/s//$dns_server1/"\
							"/OPTIONAL_DNS/s//$dns_server2/"\
							"/DEFAULT_LEASE/s//$default_lease/"\
							"/MAX_LEASE/s//$max_lease/"\
							"/SUBNET/s//$subnet/"\
							"/RANGE_MIN/s//$start/"\
							"/RANGE_MAX/s//$end/"\
							"/GATEWAY/s//$default_gateway/" >/tmp/dhcpd.conf

sudo /home/install_dhcpd_conf.sh

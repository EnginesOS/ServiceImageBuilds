#!/bin/bash

cat - > /home/configurators/saved/dhcpd_settings




 echo /home/configurators/saved/dhcpd_settings | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if test -z $domain_name
 then
 	echo "domain_name not set"
 	exit 127
 fi
 if test -z  $netmask
 then
   echo "netmask not set"
 	exit 127
 fi
 
 if test -z $subnet 
 then
   echo "subnet not set"
 	exit 127
 fi
 
 if test -z $start
 then
   echo "start not set"
 	exit 127
 fi
 
 if test -z $end$
 then
   echo "end not set"
 	exit 127
 fi

 if test -z $default_gateway
 then
   echo "default_gateway not set"
 	exit 127
 fi
 
 if test -z $dns_server1
 then
   echo "dns_server1 not set"
 	exit 127
 fi

 if test -z $dns_server2
  then
    dns_server=8.8.8.8
 fi
 
 if test -z $default_lease
  then
  	default_lease=3600
 fi
 
if test -z $max_lease
  then
  	max_lease=36000
fi

cat /home/dhcpd.conf.tmpl |sed -e /NETMASK/s//$netmask/ -e /DOMAIN_NAME/s//$domain_name/ -e /ENGINES_IP/s//$dns_server1/ -e /OPTIONAL_DNS/s//$dns_server2/ -e /DEFAULT_LEASE/s//$default_lease/ -e /MAX_LEASE/s//$max_lease/ -e /SUBNET/s//$subnet/ -e /RANGE_MIN/s//$start/ -e /RANGE_MAX/s//$end/ -e /GATEWAY/s//$default_gateway/ >/tmp/dhcpd.conf

sudo -n  /home/install_dhcpd_conf.sh

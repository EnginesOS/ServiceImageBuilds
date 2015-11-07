#!/bin/bash

service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment



	if ! test -z ${domain_name}
	 then
	  if ! test ${domain_name} = engines.internal
	   then
	 	cat  /etc/bind/templates/config_file_zone_entry.tmpl | sed " /DOMAIN/s//${domain_name}/g" > /home/bind/engines/domains/${domain_name}
	 	cat /etc/bind/templates/selfhosted.tmpl | sed "/DOMAIN/s//${domain_name}/g" | sed "/IP/s//${ip}/g" > /home/bind/engines/zones/named.conf.${domain_name}
	 	cat /home/bind/engines/domains/* > /home/bind/engines/domains.hosted
	 	kill -HUP `cat /var/run/named/named.pid`
	 	echo Success
	 	exit 0
	   fi
	 fi

#FIXME make engines.internal settable

	if test -z ${hostname}
	then
		echo Error:Missing hostname
        exit 128
    fi
    
    fqdn_str=${hostname}.engines.internal
    
  	if test -z ${ip}
	then
		 update_line=" update add $fqdn_str 30 CNAME ${parent_engine}.engines.internal"
       else
       update_line=" update add $fqdn_str 30 A $ip"
        
    fi  
    

	
	echo server 127.0.0.1 > /tmp/.dns_cmd
	echo update delete $fqdn_str >> /tmp/.dns_cmd
	echo send >> /tmp/.dns_cmd
	echo $update_line >> /tmp/.dns_cmd
	#echo update add $fqdn_str 30 A $ip >> /tmp/.dns_cmd
	echo send >> /tmp/.dns_cmd
	nsupdate -k /etc/bind/keys/ddns.private /tmp/.dns_cmd
	
	if test $? -eq 0
	then
		echo Success
		exit 0
	else
	file=`cat /tmp/.dns_cmd`
		echo Error:With nsupdate $file
		exit 128
	fi
	

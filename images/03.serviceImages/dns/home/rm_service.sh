#!/bin/bash

service_hash=$1


#. /home/engines/scripts/functions.sh

#load_service_hash_to_environment

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

	if ! test -z ${domainname}
	 then
	 	rm /home/bind/engines/domains/${domainname}
	  rm  /home/bind/domain_list/${ip_type}/${domain_name}
	 	rm /home/bind/engines/zones/named.conf.${domainname}
	 	cat /home/bind/engines/domains/* > /home/bind/engines/domains.hosted
	 	kill -HUP `cat /var/run/named/named.pid`
	 	exit
	 fi

	if test -z ${hostname}
	then
		echo Error:Missing hostname
        exit -1
    fi

    
#FIXME make engines.internal settable

	fqdn_str=${hostname}.engines.internal
	echo server 127.0.0.1 > /tmp/.dns_cmd
	echo update delete $fqdn_str >> /tmp/.dns_cmd
	echo send >> /tmp/.dns_cmd
	
	nsupdate -k /etc/bind/keys/ddns.private /tmp/.dns_cmd
	
	if test $? -ge 0
	then
		echo Success
	else
	file=`cat /tmp/.dns_cmd`
		echo Error:With nsupdate $file
		exit -1
	fi
	





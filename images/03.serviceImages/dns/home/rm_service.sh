#!/bin/bash

service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment



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
	





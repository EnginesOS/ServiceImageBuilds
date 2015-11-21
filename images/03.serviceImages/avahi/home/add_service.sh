#!/bin/bash

service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

if test -z ${hostname}
	then
		echo Error:Missing hostname
        exit 128
    fi


	touch /home/avahi/hosts/${hostname}.engines.local
	ls /home/avahi/hosts/ > /home/avahi/hosts_list
	kill -HUP `cat /tmp/avahi-publisher.pid`
	
  
		echo Success
		exit 0

	

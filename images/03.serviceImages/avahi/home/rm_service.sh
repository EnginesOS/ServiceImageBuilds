#!/bin/bash

service_hash=$1



 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if test -z ${hostname}
	then
		echo Error:Missing hostname
        exit 128
    fi

 if test -f /home/avahi/hosts/${hostname}
  then
	rm /home/avahi/hosts/${hostname}
 fi	
 	ls /home/avahi/hosts/ > /home/avahi/hosts_list
	kill -HUP `cat /tmp/avahi-publisher.pid`
  
		echo Success
		exit 0

	

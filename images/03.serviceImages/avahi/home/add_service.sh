#!/bin/bash

service_hash=$1

#. /home/engines/scripts/functions.sh

#load_service_hash_to_environment

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if test -z ${hostname}
	then
		echo Error:Missing hostname
        exit 128
    fi


	touch /home/avahi/hosts/${hostname}.local
	ls /home/avahi/hosts/ > /home/avahi/hosts_list
	if test -f /tmp/avahi-publisher.pid
		then
			kill -HUP `cat /tmp/avahi-publisher.pid`
	fi

	
#	ps -ax |grep -v grep |grep avahi-alias.py
#
#	 if test $? -ne 0
#	  then
#	  		echo "avahi publisher had crashed"
#			python /home/avahi-alias.py &
#			echo $! >/tmp/avahi-publisher.pid			
#	fi
#
		echo Success
		exit 0

	

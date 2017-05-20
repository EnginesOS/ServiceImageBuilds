#!/bin/bash

if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env
 
domain_name=`cat /home/configurators/saved/domain_name  | cut -f2 -d: | sed "s/\"//" | cut -f1 -d\"`

if test -z ${hostname}
	then
		echo Error:Missing hostname
        exit 128
    fi

 if test -f /home/avahi/hosts/${hostname}.${domain_name}
  then
	rm /home/avahi/hosts/${hostname}.${domain_name}
 fi	
 	ls /home/avahi/hosts/ > /home/avahi/hosts_list
	kill -HUP `cat /tmp/avahi-publisher.pid`
  
		echo Success
		exit 0

	

#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env
 
default_mdns_domain=`cat /home/engines/scripts/configurators/saved/default_mdns_domain  | cut -f2 -d: | sed "s/\"//" | cut -f1 -d\"`

if test -z ${hostname}
 then
   echo Error:Missing hostname
   exit 128
fi

if test -f /home/avahi/hosts/${hostname}.${default_mdns_domain}
  then
	rm /home/avahi/hosts/${hostname}.${domain_name}
fi	
 
ls /home/avahi/hosts/ > /home/avahi/hosts_list
kill -HUP `cat /tmp/avahi-publisher.pid`
  
echo Success
exit 0

	

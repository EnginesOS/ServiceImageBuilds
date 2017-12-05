#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env
 
default_mdns_domain=`cat /home/engines/scripts/configurators/saved/default_mdns_domain  | cut -f2 -d: | sed "s/\"//" | cut -f1 -d\"`

check_required_values hostname
check_required_values


if test -f /home/avahi/hosts/${hostname}.${default_mdns_domain}
  then
	rm /home/avahi/hosts/${hostname}.${default_mdns_domain}
fi	
 
ls /home/avahi/hosts/ > /home/avahi/hosts_list
kill -HUP `cat /tmp/avahi-publisher.pid`
  
echo Success
exit 0

	

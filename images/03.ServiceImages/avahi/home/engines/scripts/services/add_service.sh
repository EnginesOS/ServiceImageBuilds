#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env
 
 check_required_values hostname
check_required_values
 
default_mdns_domain=`cat /home/engines/scripts/configurators/saved/default_mdns_domain  | cut -f2 -d: | sed "s/\"//" | cut -f1 -d\"`

touch /home/avahi/hosts/${hostname}.${default_mdns_domain}
ls /home/avahi/hosts/ > /home/avahi/hosts_list
if test -f /home/engines/run/avahi-publisher.pid
 then
  kill -HUP `cat /home/engines/run/avahi-publisher.pid`
fi

echo Success
exit 0

	

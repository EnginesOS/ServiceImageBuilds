#!/bin/sh

#. /home/engines/functions/params_to_env.sh
#params_to_env
  
. /home/engines/functions/checks.sh
default_mdns_domain=`cat /home/engines/scripts/configurators/saved/default_mdns_domain  | cut -f2 -d: | sed "s/\"//" | cut -f1 -d\"`

required_values=hostname
check_required_values


if test -f /home/avahi/hosts/${hostname}.${default_mdns_domain}
  then
	rm /home/avahi/hosts/${hostname}.${default_mdns_domain}
fi	
 
/home/engine/scripts/build_hosts.sh
kill -HUP `cat /home/engines/run/avahi-publisher.pid`
  
echo Success
exit 0

	

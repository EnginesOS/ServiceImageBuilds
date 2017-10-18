#!/bin/bash



if test -f /home/engines/scripts/configurators/saved/default_domain
	then
		service_hash=`cat /home/engines/scripts/configurators/saved/default_domain`
	    echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 		. /tmp/.env	
     else
      	default_domain=$DEFAULT_DOMAIN
fi


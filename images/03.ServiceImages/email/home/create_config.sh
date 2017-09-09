#!/bin/bash

. /home/email/.dbenv

if test -f /home/configurators/saved/default_domain
	then
		service_hash=`cat /home/configurators/saved/default_domain`
	    echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 		. /tmp/.env	
     else
      	default_domain=$DEFAULT_DOMAIN
fi


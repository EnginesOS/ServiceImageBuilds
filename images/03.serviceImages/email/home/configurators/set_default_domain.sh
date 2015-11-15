#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/default_domain

. /home/engines/scripts/functions.sh

load_service_hash_to_environment


        
   	if test  ${#default_domain} -gt 5
	then

 	   echo email.${default_domain} > /etc/postfix/mailname 	
        echo "*	smtp:smtp.engines.internal" > /etc/postfix/transport
 		echo ${default_domain} :[local]	>> /etc/postfix/transport	
		postmap /etc/postfix/transport
		
		/home/create_config.sh
 	fi
 
exit 0

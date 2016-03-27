#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/default_domain

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env



        
        
  
		echo '/^(.*@*)engines.internal$/     ${1}'${default_domain} > /etc/postfix/sender_canonical
		
 		echo smtp.${default_domain} > /etc/postfix/mailname
 	    cp /etc/postfix/transport.smart /etc/postfix/transport 
        echo -n "*	:" >> /etc/postfix/transport
 		echo ${default_domain} :[email.engines.internal]	>> /etc/postfix/transport	
		postmap /etc/postfix/transport

 
exit 0

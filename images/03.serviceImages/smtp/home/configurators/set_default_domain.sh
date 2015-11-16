#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/default_domain

. /home/engines/scripts/functions.sh

load_service_hash_to_environment


echo $1 |grep = >/dev/null
        if test $? -ne 0
        then
                exit
        fi

        
        
   	if test  ${#default_domain} -gt 5
	then  
		echo '/^(.*@*)engines.internal$/     ${1}'${default_domain} > /etc/postfix/sender_canonical
		
 		echo smtp.${default_domain} > /etc/postfix/mailname
 	    cp /etc/postfix/transport.smart /etc/postfix/transport 
                echo "*	:" >> /etc/postfix/transport
 		echo ${default_domain} :[email.engines.internal]	>> /etc/postfix/transport	
		postmap /etc/postfix/transport
 	fi
 
exit 0

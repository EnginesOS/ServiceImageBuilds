#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/default_domain

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

echo ${domain_name} >/home/configurators/saved/domain


        
        
  
		echo '/^(.*@*)engines.internal$/     ${1}'${domain_name} > /etc/postfix/sender_canonical
		
 		echo smtp.${domain_name} > /etc/postfix/mailname
 	    cp /etc/postfix/transport.smart /etc/postfix/transport 
        echo  "*	:" >> /etc/postfix/transport
        if ! test -z $deliver_local 
          then
            if test  $deliver_local -eq 1 
             then                 
 				echo ${domain_name} :[email.engines.internal]	>> /etc/postfix/transport 			
 			fi
 		fi	
		postmap /etc/postfix/transport

 
exit 0

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
            if test 'true'  = $deliver_local 
             then
                 touch /home/configurators/saved/domain/delivery_local
 				echo ${domain_name} :[email.engines.internal]	>> /etc/postfix/transport
 			else
 			 if test -f /home/configurators/saved/domain/delivery_local
 			  then
 			 	rm /home/configurators/saved/domain/delivery_local
 			 fi
 			fi
 		fi	
		postmap /etc/postfix/transport

 
exit 0

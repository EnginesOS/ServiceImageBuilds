#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/default_domain

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

echo ${domain_name} >/home/configurators/saved/domain


        echo "@*local  @${domain_name}" > /etc/postfix/generic
         echo "@localhost  @${domain_name}" >> /etc/postfix/generic
         echo "@  @${domain_name}" >> /etc/postfix/generic
        postmap  /etc/postfix/generic
        
        echo "/.+/ @${domain_name}" > /etc/postfix/sender_canonical
        postmap  /etc/postfix/sender_canonical
  
		
		
 		echo smtp.${domain_name} > /etc/postfix/mailname
 		
 		if test `wc -c /etc/postfix/transport.smart | cut -f 1 -d" " ` -gt 4
 		 then
 	    	cp /etc/postfix/transport.smart /etc/postfix/transport 
 	    else
        	echo  "*	:" > /etc/postfix/transport
        fi
        if ! test -z $deliver_local 
          then
            if test  $deliver_local -eq 1 
             then                 
 				echo ${domain_name} :[email.engines.internal]	>> /etc/postfix/transport 			
 			fi
 		fi	
		postmap /etc/postfix/transport

 
exit 0

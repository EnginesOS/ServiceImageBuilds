#!/bin/bash

cat - >/home/configurators/saved/default_domain
cat /home/configurators/saved/default_domain | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env
   
 if test  ${#default_domain} -gt 5
  then
 	echo email.${default_domain} > /etc/postfix/mailname 	
    echo "*	smtp:smtp.engines.internal" > /etc/postfix/transport
 	echo ${default_domain} :[local]	>> /etc/postfix/transport	
	postmap /etc/postfix/transport
	/home/create_config.sh
fi
 
exit 0

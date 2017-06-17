#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=//home/configurators/saved/default_domain
parms_to_file_and_env

   
 if test  ${#default_domain} -gt 5
  then
 	echo email.${default_domain} > /etc/postfix/mailname 	
    echo "*	smtp:smtp.engines.internal" > /etc/postfix/transport
 	echo ${default_domain} :[local]	>> /etc/postfix/transport	
	postmap /etc/postfix/transport
	/home/create_config.sh
fi
 
exit 0

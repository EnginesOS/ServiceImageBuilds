#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/default_domain
parms_to_file_and_env

   
 if test  ${#default_domain} -gt 5
  then
 	echo email.${default_domain} > /etc/postfix/mailname 	
sudo -n /home/engines/scripts/engine/_set_mailname.sh email.${domain_name}
	
fi
 
exit 0

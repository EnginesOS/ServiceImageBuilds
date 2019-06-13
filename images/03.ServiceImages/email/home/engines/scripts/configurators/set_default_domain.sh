#!/bin/sh


echo -n ${default_domain} > /home/engines/scripts/configurators/saved/default_domain

  
 if test  ${#default_domain} -gt 5
  then
 	echo email.${default_domain} > /etc/postfix/mailname 	
    sudo -n /home/engines/scripts/engine/sudo/_set_mailname.sh email.${default_domain}
 fi
 
exit 0

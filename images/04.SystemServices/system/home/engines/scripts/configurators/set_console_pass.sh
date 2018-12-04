#!/bin/sh
 . /home/engines/functions/checks.sh

#cat - | /home/engines/bin/json_to_env >/tmp/.env
# . /tmp/.env
#rm /tmp/.env
  
   	if test -n $console_password
	then  
		mgmt_ip=$CONTROL_IP
	ssh  -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /home/engines/.ssh/system/update_engines_console_password engines@${mgmt_ip} /opt/engines/bin/update_engines_console_password.sh $console_password
 		exit $?	
 	fi
 


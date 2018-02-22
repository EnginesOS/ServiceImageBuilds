#!/bin/bash

service_hash=$1

echo $1 >/home/engines/scripts/configurators/saved/ssh_master_key


 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env



        
   	if test -n $ssh_master_key
	then  
	 echo ssh-rsa  $ssh_master_key engines  > /home/engines/.ssh/authorized_keys
		
 	fi
 


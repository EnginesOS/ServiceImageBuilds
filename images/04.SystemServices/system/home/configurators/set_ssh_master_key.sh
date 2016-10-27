#!/bin/bash

service_hash=$1

cat - >/home/configurators/saved/ssh_master_key


 echo - | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env



        
   	if test -n $ssh_master_key
	then  
	 echo ssh-rsa  $ssh_master_key engines  > /home/engines/.ssh/authorized_keys
		
 	fi
 


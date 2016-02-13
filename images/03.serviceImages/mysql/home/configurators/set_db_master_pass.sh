#!/bin/bash

service_hash=$1


 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

 
   	if test -n $db_master_pass
	then  
	mysql -urma -e "set password for 'root'@'%' = PASSWORD('$db_master_pass'); "
	
 			
 	fi
 


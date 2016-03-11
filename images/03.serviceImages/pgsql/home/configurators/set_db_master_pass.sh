#!/bin/bash

service_hash=$1



 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env



echo $1 |grep = >/dev/null
        if test $? -ne 0
        then
                exit
        fi


        
   	if test -n $db_master_pass
	then  
	
	 echo  "alter user rma with PASSWORD '$db_master_pass';" | psql postgres postgres         
 			
 	fi
 


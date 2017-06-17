#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

 
if test -n $db_master_pass
 then  
  mysql -urma -e "set password for 'root'@'%' = PASSWORD('$db_master_pass'); "	 			
fi
 


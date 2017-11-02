#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env
 required_values="db_master_pass"
check_required_values
 
if test -n $db_master_pass
 then  
  mysql -urma -e "set password for 'root'@'%' = PASSWORD('$db_master_pass'); "	 			
fi
 


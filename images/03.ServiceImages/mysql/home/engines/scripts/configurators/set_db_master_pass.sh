#!/bin/sh


 . /home/engines/functions/checks.sh
 required_values="db_master_pass"
check_required_values
 
if test -n $db_master_pass
 then  
  mysql -urma -e "set password for 'root'@'%' = PASSWORD('$db_master_pass'); "	 			
fi
 


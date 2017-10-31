#!/bin/bash


. /home/engines/functions/params_to_env.sh
params_to_env
set > /tmp/full_env
 if test $container_type = container
  then
   top_ou=applications
 elif $container_type = services     
 then 
 	top_ou=servics
 else
   echo '{"Result":"Failed","Error Mesg":"Invalid container type"}'
   exit 127	
  fi
  
  
  export top_ou parent_engine container_type cn
  
  if test $type = group
 then
	/home/engines/scripts/services/group/rm_group.sh
elif test $type = ou
 then
 /home/engines/scripts/services/ou/rm_ou.sh
else
    echo '{"Result":"Failed","Error Mesg":"Invalid type"}'
   exit 127	
  fi 
  
  
 

  

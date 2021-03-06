#!/bin/sh


 . /home/engines/functions/checks.sh

required_values="type parent_engine container_type"
check_required_values

set > /tmp/full_env
 if test $container_type = app
  then
   top_ou=applications
 elif $container_type = services     
 then 
 	top_ou=servics
 else
   echo '{"Result":"Failed","Error Mesg":"Invalid container type"}'
   exit 1
  fi
  
  
  export top_ou parent_engine container_type cn
  
  if test $type = group
 then
	/home/engines/scripts/services/group/rm_group.sh
elif test $type = ou
 then
 /home/engines/scripts/services/ou/rm_ou.sh
elif test $type = access
 then
  /home/engines/scripts/ldap/ldapdelete.sh uid=${parent_engine},ou=hosts,ou=engines,dc=engines,dc=internal
   #/home/engines/scripts/services/access/rm_access.sh
else
    echo '{"Result":"Failed","Error Mesg":"Invalid type"}'
   exit 1	
fi 
  
  
 

  

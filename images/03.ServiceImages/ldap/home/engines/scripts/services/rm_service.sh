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
 if test -z $cn
  then
   dn="ou=$parent_engine,ou=$container_types,ou=Groups,dc=engines,dc=internal"
 else
   dn=cn=$cn,ou=$parent_engine,ou=$top_ou,ou=Groups,dc=engines,dc=internal"
 fi
 
 /home/engines/scripts/ldap/ldapdelete.sh "$dn"


  

#!/bin/sh

 . /home/engines/functions/checks.sh

set > /tmp/full_env

required_values="type parent_engine container_type"
check_required_values

 . /home/engines/functions/ldap/support_functions.sh

 if test $container_type = app
  then
   top_ou=applications
 elif $container_type = services     
 then 
 	top_ou=services
 else
   echo '{"Result":"Failed","Error Mesg":"Invalid container type"}'
   exit 1
  fi
  
export top_ou parent_engine container_type cn auth read_access write_access

test_result()
{
res=$?
if test $? -ne 0
 then
  exit $res
fi
}

if test $type = group
 then
	/home/engines/scripts/services/group/add_group.sh
	test_result
elif test $type = ou
 then
    /home/engines/scripts/services/ou/add_ou.sh
    test_result
elif test $type = access
 then
   export parent_engine auth ldap_password access_dn
   /home/engines/scripts/services/access/create_ldap_host_entry.sh
   test_result
else
   echo '{"Result":"Failed","Error Mesg":"Invalid type"}'
   exit 1
fi 
  

  
 


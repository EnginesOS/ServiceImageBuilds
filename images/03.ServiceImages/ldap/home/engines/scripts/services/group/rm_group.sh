#/!bin/bash

if test -z $cn
  then
   dn="ou=$parent_engine,ou=$container_types,ou=Groups,dc=engines,dc=internal"
 else
   dn="cn=$cn,ou=$parent_engine,ou=$top_ou,ou=Groups,dc=engines,dc=internal"
 fi
 
 /home/engines/scripts/ldap/ldapdelete.sh "$dn"

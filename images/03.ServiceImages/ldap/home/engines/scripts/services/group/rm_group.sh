#/!bin/bash


dn="cn=$cn,ou=$parent_engine,ou=$top_ou,ou=Groups,dc=engines,dc=internal"

 
/home/engines/scripts/ldap/ldapdelete.sh "$dn"
/home/engines/scripts/services/access/rm_access.sh "$dn"
 
 

/home/engines/scripts/ldap/ldapsearch.sh ou=${top_ou},ou=Groups,dc=engines,dc=internal ou=$parent_engine  | grep cn
  if test $? -ne 0
   then
    dn="ou=$parent_engine,ou=${top_ou},ou=Groups,dc=engines,dc=internal"
     /home/engines/scripts/ldap/ldapdelete.sh "$dn"
  fi
   
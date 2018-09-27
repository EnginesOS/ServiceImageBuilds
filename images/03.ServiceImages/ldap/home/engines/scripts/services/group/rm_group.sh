#/!bin/bash


dn="cn=$cn,ou=$parent_engine,ou=$top_ou,ou=Groups,dc=engines,dc=internal"

 
/home/engines/scripts/ldap/ldapdelete.sh "$dn"
/home/engines/scripts/services/access/rm_access.sh "$dn"
 
 

c=`/home/engines/scripts/ldap/ldapsearch.sh ou=${top_ou},ou=Groups,dc=engines,dc=internal ou=$parent_engine  |grep dn |wc -l`
  if test $c -eq 1
   then
    dn="ou=$parent_engine,ou=${top_ou},ou=Groups,dc=engines,dc=internal"
     /home/engines/scripts/ldap/ldapdelete.sh "$dn"
  fi
   
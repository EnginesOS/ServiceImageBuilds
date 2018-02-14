#/!bin/bash


if test -z $cn
  then
   dn="ou=$parent_engine,ou=$top_ou,ou=Containers,ou=Engines,dc=engines,dc=internal"
   delou=1
 else
   dn="ou=$cn,ou=$parent_engine,ou=$top_ou,ou=Containers,ou=Engines,dc=engines,dc=internal"
 fi
 
 /home/engines/scripts/ldap/ldapdelete.sh "$dn"
 
 
if ! test $delou
 then
  c=`/home/engines/scripts/ldap/ldapsearch.sh ou=${top_ou},ou=Containers,ou=Engines,dc=engines,dc=internal ou=$parent_engine  |wc -l`
   if test $c -eq 0
    then
     dn="ou=$parent_engine,ou=$top_ou,ou=Containers,ou=Engines,dc=engines,dc=internal"
      /home/engines/scripts/ldap/ldapdelete.sh "$dn"
      /home/engines/scripts/services/access/rm_access.sh ou=${top_ou},ou=Containers,ou=Engines,dc=engines,dc=internal
   fi
fi   
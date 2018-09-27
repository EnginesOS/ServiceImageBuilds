#/!bin/bash


dn="cn=$cn,ou=$parent_engine,ou=$top_ou,ou=Groups,dc=engines,dc=internal"

 
/home/engines/scripts/ldap/ldapdelete.sh "$dn"
echo /home/engines/scripts/ldap/ldapdelete.sh "$dn" >/tmp/rm_grp
/home/engines/scripts/services/access/rm_access.sh "$dn"
 echo /home/engines/scripts/services/access/rm_access.sh "$dn"  >/tmp/rm_grp_access
 

c=`/home/engines/scripts/ldap/ldapsearch.sh ou=${top_ou},ou=Groups,dc=engines,dc=internal ou=$parent_engine  dn |grep dn |wc -l`
/home/engines/scripts/ldap/ldapsearch.sh ou=${top_ou},ou=Groups,dc=engines,dc=internal ou=$parent_engine  dn |grep dn >/tmp/group_tl_list
  if test $c -eq 1
   then
    dn="ou=$parent_engine,ou=${top_ou},ou=Groups,dc=engines,dc=internal"
     /home/engines/scripts/ldap/ldapdelete.sh "$dn"
     echo  /home/engines/scripts/ldap/ldapdelete.sh "$dn" >/tmp/rm_group_tld
  fi
   
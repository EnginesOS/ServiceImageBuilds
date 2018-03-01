#!bin/bash

#if ! engine group ou exist
#create engine group ou
. /home/engines/functions/ldap/support_functions.sh

c=`/home/engines/scripts/ldap/ldapsearch.sh ou=$parent_engine,ou=${top_ou},ou=Groups,dc=engines,dc=internal ou=$parent_engine  |wc -l`
 
if test $c -eq 0
 then
  cat /home/engines/templates/ldap/services/add_group_ou.ldif | while read LINE
   do
     eval echo "$LINE" >> $LDIF_FILE
   done

 cat $LDIF_FILE |sudo /home/engines/scripts/ldap/sudo/_ldapadd.sh $* &> $LDAP_OUTF
export top_ou parent_engine container_type cn auth password ldap_dn
 /home/engines/scripts/services/access/add_access.sh ou=$parent_engine,ou=${top_ou},ou=Groups,dc=engines,dc=internal
r=$?

if $r -ne 0
 then 
  exit $r
fi
result=$?
if test $result -ne 0
 then
  process_ldap_result
  exit 1
 fi
fi

rm $LDIF_FILE 

if test -z $cn
 then
  cn=$parent_engine
fi 
gidNumber=`/home/engines/scripts/ldap/next_gid.sh`
cat /home/engines/templates/ldap/services/add_group.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done
cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh 
r=$?

if $r -ne 0
 then 
  exit $r
fi
#!bin/bash

#if ! engine group ou exist
#create engine group ou
c=`/home/engines/scripts/ldap/ldapsearch.sh ou=${top_ou},ou=Groups,dc=engines,dc=internal ou=$parent_engine  |wc -l`
 . /home/engines/functions/ldap/support_functions.sh
if test $c -eq 0
 then
  cat /home/engines/templates/ldap/services/add_group_ou.ldif | while read LINE
   do
     eval echo $LINE >> $LDIF_FILE
   done

 cat $LDIF_FILE |sudo /home/engines/scripts/ldap/sudo/_ldapadd.sh $* &> $LDAP_OUTF 

result=$?
if test $result -ne 0
 then
  process_ldap_result
  exit 127
 fi
fi

if test -z $cn
 then
  cn=$parent_engine
fi 
gidNumber=`/home/engines/scripts/ldap/next_gid.sh`
cat /home/engines/templates/ldap/services/add_group.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done
cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh 

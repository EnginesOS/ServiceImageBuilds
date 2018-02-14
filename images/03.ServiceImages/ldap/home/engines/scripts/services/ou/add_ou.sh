#!bin/bash
. /home/engines/functions/ldap/support_functions.sh

c=`/home/engines/scripts/ldap/ldapsearch.sh ou=${top_ou},ou=Containers,ou=Engines,dc=engines,dc=internal ou=$parent_engine  |wc -l`

 
if test $c -eq 0
 then
  cat /home/engines/templates/ldap/services/add_ou_top.ldif | while read LINE
   do
     eval echo $LINE >> $LDIF_FILE
   done
cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh 

 /home/engines/scripts/serivces/access/add_access.sh ou=${top_ou},ou=Containers,ou=Engines,dc=engines,dc=internal
fi

rm  $LDIF_FILE
   
cat /home/engines/templates/ldap/services/add_ou.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done
cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh

rm  $LDIF_FILE

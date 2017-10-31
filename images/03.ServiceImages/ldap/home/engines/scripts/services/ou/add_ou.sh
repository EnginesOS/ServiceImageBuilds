#!bin/bash

cat /home/engines/templates/ldap/services/add_$type.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done
cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh 

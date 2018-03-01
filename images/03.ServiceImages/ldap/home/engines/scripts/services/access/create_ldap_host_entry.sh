#!/bin/bash
LDIF_FILE=`mktemp`
sha_pass=`slappasswd -h {SHA} -s $ldap_password`
cat /home/engines/templates/ldap/services/add_host_entry.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done
cp $LDIF_FILE /tmp/create_account
cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh
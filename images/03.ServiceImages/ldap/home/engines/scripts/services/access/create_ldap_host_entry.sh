#!/bin/bash
LDIF_FILE=`mktemp`
sha_pass=`echo $password | sha1sum | awk '{ print $1}'`
echo Sa pass is $sha_pass
cat /home/engines/templates/ldap/services/add_host_entry.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done
cp $LDIF_FILE /tmp/create_account
cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh
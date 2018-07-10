#!/bin/bash
. /home/engines/functions/ldap/support_functions.sh

#FIXME check curent password
password=`cat -`

shapass=`echo -n $password  | openssl dgst -sha1 -binary | openssl enc -base64`

cat /home/engines/templates/ldap/config_pass.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done
kinit -kt /etc/krb5kdc/keys/ldap.keytab 
ldapmodify -H ldapi:/// -f $LDIF_FILE
result=$?
rm $LDIF_FILE

echo $password > /var/lib/ldap/.tok

kdestroy
exit $result


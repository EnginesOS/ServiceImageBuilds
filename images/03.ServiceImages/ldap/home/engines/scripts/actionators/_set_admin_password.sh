#!/bin/sh
. /home/engines/functions/ldap/support_functions.sh

#FIXME check curent password
password=`cat -`
shapass=`echo -n "$password"  |sha1sum |cut -f1 -d" "`

cat /home/engines/templates/ldap/root_password.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done
kinit -kt /etc/krb5kdc/keys/ldap.keytab 
ldapmodify -H ldapi:/// -f $LDIF_FILE
result=$?
rm $LDIF_FILE
#ldappasswd -D cn=admin,dc=engines,dc=internal -H ldapi:/// -s $password
kdestroy
exit $result


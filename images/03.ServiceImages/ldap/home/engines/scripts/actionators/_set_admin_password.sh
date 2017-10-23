#!/bin/sh

#password=$2
#current_password=$1

cat /home/engines/templates/ldap/root_password.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done
kinit -kt /etc/krb5kdc/keys/ldap.keytab 
lpdapmodify -H ldapi:/// -f $LDIF_FILE
result=$?
rm $LDIF_FILE
#ldappasswd -D cn=admin,dc=engines,dc=internal -H ldapi:/// -s $password
kdestroy
exit $result

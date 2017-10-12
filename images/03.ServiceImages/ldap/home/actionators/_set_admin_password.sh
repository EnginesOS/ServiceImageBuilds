#!/bin/sh

#password=$2
#current_password=$1

cat /home/tmpls/root_password.ldif | while read LINE
do
 eval echo $LINE >> /tmp/ldif
done
kinit -kt /etc/krb5kdc/keys/ldap.keytab 
lpdapmodify -H ldapi:/// -f /tmp/ldif
result=$?
rm /tmp/ldif
#ldappasswd -D cn=admin,dc=engines,dc=internal -H ldapi:/// -s $password
kdestroy
exit $result


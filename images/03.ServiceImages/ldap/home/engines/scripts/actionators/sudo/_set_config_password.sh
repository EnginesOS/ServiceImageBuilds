#!/bin/bash
. /home/engines/functions/ldap/support_functions.sh

#FIXME check curent password

password=`cat -`
salt=`head -c 40 /dev/random | base64 | sed -e 's/+/./g' |  cut -b 10-25`
cat /home/engines/templates/ldap/admin_user_pass.ldif $LDIF_FILE
crypt=`mkpasswd --rounds 500000 -m sha-512 --salt $salt $password`
echo 'olcRootPW: {CRYPT}'$crypt >> $LDIF_FILE

kinit -kt /etc/krb5kdc/keys/ldap.keytab 
ldapmodify -H ldapi:/// -f $LDIF_FILE
result=$?
rm $LDIF_FILE

cat /var/lib/ldap/{.tok,.tok.last}
echo $password > /var/lib/ldap/.tok

kdestroy
exit $result


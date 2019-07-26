#!/bin/bash
. /home/engines/functions/ldap/support_functions.sh

#FIXME check curent password
password=`cat -`
#shapass=`echo -n $password  | openssl dgst -sha1 -binary | openssl enc -base64`
salt=`head -c 40 /dev/random | base64 | sed -e 's/+/./g' |  cut -b 10-25`
cp /home/engines/templates/ldap/admin_user_pass.ldif  $LDIF_FILE
mkpasswd --rounds 500000 -m sha-512 --salt $salt $password >> $LDIF_FILE
echo "" >> $LDIF_FILE
#cp /home/engines/templates/ldap/admin_user_pass.ldif  $LDIF_FILE
#cat /home/engines/templates/ldap/admin_user_pass.ldif | while read LINE
#do
# eval echo "$LINE" >> $LDIF_FILE
#done
kinit -kt /etc/krb5kdc/keys/ldap.keytab 
ldapmodify -H ldapi:/// -f $LDIF_FILE
result=$?
rm $LDIF_FILE

kdestroy
exit $result


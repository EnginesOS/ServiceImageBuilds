#/bin/bash

kinit -kt /etc/krb5kdc/keys/email.keytab 

/usr/bin/ldapmodify -h ldap $* 
ldap_result=$?
kdestroy
exit $ldap_result
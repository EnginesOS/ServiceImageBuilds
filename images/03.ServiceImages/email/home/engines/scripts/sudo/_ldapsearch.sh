#/bin/bash

kinit -kt /etc/krb5kdc/keys/email.keytab 
/usr/bin/ldapsearch -h ldap -LLL $*
ldap_result=$?
kdestroy
exit $ldap_result
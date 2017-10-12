#/bin/bash

kinit -kt /etc/krb5kdc/keys/uadmin.keytab 
/usr/bin/ldapsearch -h ldap -LLL -b "$1" $2 $3 $4 $5 $6 $7 $8 
ldap_result=$?
kdestroy
exit $ldap_result
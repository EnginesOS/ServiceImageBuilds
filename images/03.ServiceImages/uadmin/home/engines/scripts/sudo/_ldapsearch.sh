#/bin/bash

kinit -kt /etc/krb5kdc/keys/uadmin.keytab 
/usr/bin/ldapsearch -h ldap -LLL $*
ldap_result=$?
export ldap_result
kdestroy
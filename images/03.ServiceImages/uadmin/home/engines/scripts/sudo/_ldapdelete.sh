#/bin/bash

kinit -kt /etc/krb5kdc/keys/uadmin.keytab 

/usr/bin/ldapdelete -h ldap $* 
ldap_result=$?
kdestroy
exit $ldap_result
#/bin/bash

kinit -kt /etc/krb5kdc/keys/email.keytab 
/usr/bin/ldapadd -h ldap $*  
ldap_result=$?
export ldap_result
kdestroy
exit $ldap_result
#/bin/bash

kinit -kt /etc/krb5kdc/keys/uadmin.keytab 
/usr/bin/ldapadd -h ldap $*  
ldap_result=$?
export ldap_result
kdestroy
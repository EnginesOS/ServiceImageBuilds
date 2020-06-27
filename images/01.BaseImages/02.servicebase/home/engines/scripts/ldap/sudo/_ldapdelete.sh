#!/bin/sh


kinit -kt /etc/krb5kdc/keys/${CONTAINER_NAME}.keytab 

/usr/bin/ldapdelete -h ldap $* 
ldap_result=$?
kdestroy
exit $ldap_result
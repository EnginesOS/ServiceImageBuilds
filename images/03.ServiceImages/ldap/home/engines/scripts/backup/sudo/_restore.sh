#!/bin/sh

kinit -kt /etc/krb5kdc/keys/ldap.keytab 
cat - | slapadd -v -c 
result=$?

kdestroy
exit $result

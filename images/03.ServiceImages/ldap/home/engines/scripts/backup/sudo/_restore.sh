#!/bin/sh

kinit -kt /etc/krb5kdc/keys/ldap.keytab 
ldapmodify -H ldapi:/// -f -
result=$?

kdestroy
exit $result

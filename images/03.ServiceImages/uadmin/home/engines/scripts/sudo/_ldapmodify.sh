#/bin/bash

kinit -kt /etc/krb5kdc/keys/uadmin.keytab 
/usr/bin/ldapmodify -h ldap $*
kdestroy
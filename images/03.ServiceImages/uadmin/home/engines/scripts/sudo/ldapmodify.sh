#/bin/bash


kinit -t /etc/krb5kdc/keys/uadmin.keytab 
/usr/bin/ldapmodify $*
kdestroy
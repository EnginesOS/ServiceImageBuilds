#/bin/bash

kinit -kt /etc/krb5kdc/keys/uadmin.keytab 
/usr/bin/ldapdelete -h ldap $*
kdestroy
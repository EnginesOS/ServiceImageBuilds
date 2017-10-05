#/bin/bash

kinit -kt /etc/krb5kdc/keys/uadmin.keytab  >& /dev/null
ldapmodify -h ldap /home/templates/incre_uid.ldif >& /dev/null
ldapsearch -h ldap -b "cn=uidNext,dc=engines,dc=internal" -LLL uidNumber |grep uidNumber |cut -f2.-d:
kdestroy
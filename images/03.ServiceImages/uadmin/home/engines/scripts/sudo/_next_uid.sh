#/bin/bash

kinit -kt /etc/krb5kdc/keys/uadmin.keytab 
ldapmodify -h ldap -f /home/templates/incre_uid.ldif 
uid=`ldapsearch -h ldap -b "cn=uidNext,dc=engines,dc=internal" -LLL uidNumber |grep uidNumber |cut -f2 -d:`
kdestroy
echo $uid
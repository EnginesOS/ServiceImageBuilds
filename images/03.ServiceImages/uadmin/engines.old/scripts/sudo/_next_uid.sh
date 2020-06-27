##!/bin/bash
#
#kinit -kt /etc/krb5kdc/keys/uadmin.keytab 
#ldapmodify -h ldap -f /home/templates/incre_uid.ldif 
# if test $? -ne 0 
#  then
#   exit $?
#  fi
#uid=`ldapsearch -h ldap -b "cn=uidNext,ou=System,ou=Engines,dc=engines,dc=internal" -LLL uidNumber |grep uidNumber |cut -f2 -d:`
#kdestroy
#echo $uid
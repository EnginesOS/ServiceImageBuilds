#!/bin/bash

echo /home/engines/scripts/ldap/ldapmodify.sh -f /home/engines/templates/ldap/incre_uid.ldif >/tmp/incr
/home/engines/scripts/ldap/ldapmodify.sh -f /home/engines/templates/ldap/incre_uid.ldif >/dev/null
uid=`/home/engines/scripts/ldap/ldapsearch.sh "cn=uidNext,ftp,ou=Services,ou=Containers,ou=Engines,dc=engines,dc=internal" uidNumber |grep uidNumber |cut -f2 -d:`
echo /home/engines/scripts/ldap/ldapsearch.sh "cn=uidNext,ftp,ou=Services,ou=Containers,ou=Engines,dc=engines,dc=internal" >/tmp/getid
echo $uid

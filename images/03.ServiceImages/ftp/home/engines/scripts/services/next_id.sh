#!/bin/sh

/home/engines/scripts/ldap/ldapmodify.sh -f /home/engines/templates/ldap/incre_uid.ldif >/dev/null
uid=`/home/engines/scripts/ldap/ldapsearch.sh "cn=uidNext,ou=ftp,ou=Services,ou=Containers,ou=Engines,dc=engines,dc=internal" uidNumber |grep uidNumber |cut -f2 -d:`

echo $uid

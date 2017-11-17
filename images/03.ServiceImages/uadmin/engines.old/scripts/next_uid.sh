#!/bin/bash

#sudo -n /home/engines/scripts/sudo/_next_uid.sh

/home/engines/scripts/ldapmodify.sh -f /home/templates/incre_uid.ldif >/dev/null
uid=`/home/engines/scripts/ldap/ldapsearch.sh "cn=uidNext,ou=System,ou=Engines,dc=engines,dc=internal" uidNumber |grep uidNumber |cut -f2 -d:`

echo $uid
#!/bin/sh

#sudo -n /home/engines/scripts/sudo/_next_uid.sh

/home/engines/scripts/ldap/ldapmodify.sh -f /home/engines/functions/templates/ldap/incre_uid.ldif >/dev/null
uid=`/home/engines/scripts/ldap/ldapsearch.sh "cn=uidNext,ou=System,ou=Engines,dc=engines,dc=internal" uidNumber |grep uidNumber |cut -f2 -d:`

echo $uid


exit $ldap_result
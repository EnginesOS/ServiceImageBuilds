#!/bin/sh


/home/engines/scripts/ldap/ldapmodify.sh -f /home/engines/functions/templates/ldap/incre_gid.ldif >/dev/null
gid=`/home/engines/scripts/ldap/ldapsearch.sh "cn=gidNext,ou=System,ou=Engines,dc=engines,dc=internal" gidNumber |grep gidNumber |cut -f2 -d:`

echo $gid



exit $ldap_result
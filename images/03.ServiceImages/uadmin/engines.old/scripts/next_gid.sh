#!/bin/bash


/home/engines/scripts/ldapmodify.sh -f /home/templates/incre_gid.ldif >/dev/null
gid=`/home/engines/scripts/ldap/ldapsearch.sh "cn=gidNext,ou=System,ou=Engines,dc=engines,dc=internal" gidNumber |grep gidNumber |cut -f2 -d:`

echo $gid
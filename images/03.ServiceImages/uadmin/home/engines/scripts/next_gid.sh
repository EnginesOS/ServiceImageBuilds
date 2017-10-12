#!/bin/bash


/home/engines/scripts/ldapmodify.sh -f /home/templates/incre_gid.ldif >/dev/null
gid=`/home/engines/scripts/ldapsearch.sh -b "cn=gidNext,dc=engines,dc=internal" gidNumber |grep gidNumber |cut -f2 -d:`

echo $gid
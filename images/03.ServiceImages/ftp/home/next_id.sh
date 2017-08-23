#!/bin/bash


echo "dn: cn=uidNext,dc=engines,dc=internal
changetype: modify
increment: uidNumber
uidNumber: 1" |  ldapmodify -H ldap://ldap/ &>/null

ldapsearch -H ldap://ldap/ -b cn=uidNext,dc=engines,dc=internal |grep uidNumber | awk '{print $2}'
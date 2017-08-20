#!/bin/bash


echo "dn: cn=uidNext,dc=engines,dc=internal
changetype: modify
increment: uidNumber
uidNumber: 1" |  ldapmodify 

ldapsearch -b cn=uidNext,dc=engines,dc=internal |grep uidNu | awk '{print $2}'
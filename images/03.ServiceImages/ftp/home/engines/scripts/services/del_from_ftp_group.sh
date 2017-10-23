#!/bin/bash

echo "
dn: cn=ftp,ou=Groups,dc=engines,dc=internal
changetype: modify
delete: memberUid
memberUid: $1 
" | ldapmodify -H ldap://ldap/
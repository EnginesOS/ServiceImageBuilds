#!/bin/bash

echo "
dn: cn=ftp users,ou=ftp,ou=Services,ou=Groups,dc=engines,dc=internal
changetype: modify
delete: memberUid
memberUid: $1 
" | ldapmodify -H ldap://ldap/
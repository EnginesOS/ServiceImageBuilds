#!/bin/bash

. /home/actionators/x400_to_json.sh

/home/engines/scripts/ldapsearch.sh "ou=People,dc=engines,dc=internal"  objectClass=posixAccount mailacceptinggeneralid > $LDAP_FILE

echo '{"email_adresses":{"user_adresses":'

key=memberID
map_ldap_to_json_array
echo ',"group_adresses":'
/home/engines/scripts/ldapsearch.sh "ou=Distribution Groups,dc=engines,dc=internal"  objectClass=posixGroup cn > $LDAP_FILE
key=cn
map_ldap_to_json_array
echo '}}'
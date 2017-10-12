#!/bin/bash
. /home/actionators/x400_to_json.sh

/home/engines/scripts/ldapsearch.sh "ou=People,dc=engines,dc=internal"  objectClass=posixAccount memberID > $LDAP_FILE

echo '{"user_ids":'
key=memberID
map_ldap_to_json_array
echo '}'
#!/bin/bash
. /home/engines/scripts/actionators/x400_to_json.sh

/home/engines/scripts/ldapsearch.sh "ou=People,dc=engines,dc=internal"  objectClass=posixAccount uid > $LDAP_FILE

echo '{"user_ids":'
key=uid
map_ldap_to_json_array
echo '}'
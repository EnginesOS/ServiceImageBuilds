#!/bin/bash
. /home/engines/scripts/actionators/x400_to_json.sh

/home/engines/scripts/ldap/ldapsearch.sh "ou=Groups,dc=engines,dc=internal"  objectClass=posixGroup cn > $LDAP_FILE

echo '{"group_names":'
key=cn
map_ldap_to_json_array
echo '}'
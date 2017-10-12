#!/bin/bash

. /home/actionators/x400_to_json.sh

/home/engines/scripts/ldapsearch.sh "ou=Groups,dc=engines,dc=internal"  objectClass=posixGroup cn > $LDAP_FILE


echo '{"user_ids":'
key=cn
map_ldap_to_json_array
echo '}'
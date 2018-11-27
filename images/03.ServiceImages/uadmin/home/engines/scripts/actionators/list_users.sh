#!/bin/sh

. /home/engines/scripts/actionators/x400_to_json.sh

/home/engines/scripts/ldap/ldapsearch.sh "ou=People,dc=engines,dc=internal"  objectClass=posixAccount > $LDAP_FILE


echo '{"users":'
ldap_to_json_array
echo '}'
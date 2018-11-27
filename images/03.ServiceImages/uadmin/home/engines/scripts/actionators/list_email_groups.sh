#!/bin/sh

 . /home/engines/functions/checks.sh
 
. /home/engines/scripts/actionators/x400_to_json.sh

/home/engines/scripts/ldap/ldapsearch.sh "ou=Distribution Groups,dc=engines,dc=internal"  objectClass=posixGroup > $LDAP_FILE


echo '{"groups":'
ldap_to_json_array
echo '}'



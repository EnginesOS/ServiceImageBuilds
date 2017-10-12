#!/bin/bash
#. /home/engines/functions/params_to_env.sh
#params_to_env
. /home/actionators/x400_to_json.sh

/home/engines/scripts/ldapsearch.sh "ou=People,dc=engines,dc=internal"  objectClass=posixAccount > $LDAP_FILE


echo '{"users":'
ldap_to_json_array
echo '}'
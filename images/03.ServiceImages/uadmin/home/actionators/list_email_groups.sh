#!/bin/bash
#. /home/engines/functions/params_to_env.sh
#params_to_env
. /home/engines/scripts/actionators/x400_to_json.sh

/home/engines/scripts/ldapsearch.sh "ou=Distribution Groups,dc=engines,dc=internal"  objectClass=posixGroup > $LDAP_FILE


echo '{"groups":'
ldap_to_json_array
echo '}'



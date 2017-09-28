#!/bin/bash
#. /home/engines/functions/params_to_env.sh
#parms_to_env
. /home/actionators/x400_to_json.sh

/home/engines/scripts/ldapsearch.sh -LLL  -b "ou=People,dc=engines,dc=internal" -h ldap objectClass=posixAccount > $LDAP_FILE


echo '{"users":'
ldap_to_json_array
echo '}'
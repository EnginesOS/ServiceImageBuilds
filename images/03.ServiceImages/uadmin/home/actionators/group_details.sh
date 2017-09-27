#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env

. /home/actionators/x400_to_json.sh

/home/engines/scripts/ldapsearch.sh -LLL -b "cn=$group_name,ou=Groups,dc=engines,dc=internal" -h ldap objectClass=posixGroup > $LDAP_FILE 

echo '{"group":'
ldap_to_json
echo '}'
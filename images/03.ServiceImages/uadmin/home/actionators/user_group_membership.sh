#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env
. /home/actionators/x400_to_json.sh

/home/engines/scripts/ldapsearch.sh -LLL  -b "ou=Groups,dc=engines,dc=internal" -h ldap  memberUid=$uid cn > $LDAP_FILE


echo '{"groups":'
key=cn
map_ldap_to_json_array
echo '}'
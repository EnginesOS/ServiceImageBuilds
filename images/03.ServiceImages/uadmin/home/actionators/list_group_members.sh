#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z $group_name
 then
  echo '{"error":"No Group Name specified"}'
  exit 127
fi
. /home/actionators/x400_to_json.sh

/home/engines/scripts/ldapsearch.sh -LLL -b "cn=$group_name,ou=Groups,dc=engines,dc=internal" -h ldap objectClass=posixGroup memberUid > $LDAP_FILE 

echo '{"members":'
key=memberUid
map_ldap_to_json_array
echo '}'
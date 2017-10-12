#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

if test -z $uid
 then
  echo '{"error":"No uid specified"}'
  exit 127
fi

. /home/actionators/x400_to_json.sh

/home/engines/scripts/ldapsearch.sh "ou=People,dc=engines,dc=internal" uid=$uid mailacceptinggeneralid  > $LDAP_FILE

echo '{"email_addresses":'
key=mailacceptinggeneralid
map_ldap_to_json_array
echo '}'



 
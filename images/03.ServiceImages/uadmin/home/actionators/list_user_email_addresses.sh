#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z $uid
 then
  echo '{"error":"No ui specified"}'
  exit 127
fi

. /home/actionators/x400_to_json.sh

/home/engines/scripts/ldapsearch.sh -b "ou=People,dc=engines,dc=internal" -LLL -h ldap uid=$uid mailacceptinggeneralid  > $LDAP_FILE

echo '{"email_addresses":'
key=mailacceptinggeneralid
map_ldap_to_json_array
echo '}'



 
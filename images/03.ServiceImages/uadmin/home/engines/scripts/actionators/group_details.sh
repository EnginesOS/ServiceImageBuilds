#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

. /home/engines/functions/ldap/support_functions.sh

if test -z $group_name
 then
  echo '{"error":"No Group Name specified"}'
  exit 127
fi
. /home/engines/scripts/actionators/x400_to_json.sh

/home/engines/scripts/ldap/ldapsearch.sh "cn=$group_name,ou=Groups,dc=engines,dc=internal" objectClass=posixGroup > $LDAP_FILE 

echo '{"group":'
ldap_to_json
echo '}'
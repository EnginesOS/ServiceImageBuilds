#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

if test -z $email_address
 then
  echo '{"error":"No email_address specified"}'
  exit 127
fi

. /home/engines/scripts/actionators/x400_to_json.sh

/home/engines/scripts/ldapsearch.sh "ou=People,dc=engines,dc=internal" mailacceptinggeneralid=$email_address uid> $LDAP_FILE

echo '{"user":'
ldap_to_json
echo '}'
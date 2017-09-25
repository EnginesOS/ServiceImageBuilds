#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z $uid
 then
  echo '{"error":"No ui specified"}'
  exit 127
fi

details=`/home/engines/scripts/ldapsearch -b "ou=People,dc=engines,dc=internal" -h ldap uid=$uid '
 
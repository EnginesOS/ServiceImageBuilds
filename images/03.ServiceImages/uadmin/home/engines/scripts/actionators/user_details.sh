#!/bin/sh

 . /home/engines/functions/checks.sh
 
if test -z $uid
 then
  echo '{"error":"No ui specified"}'
  exit 127
fi

. /home/engines/scripts/actionators/x400_to_json.sh

/home/engines/scripts/ldap/ldapsearch.sh "ou=People,dc=engines,dc=internal" uid=$uid > $LDAP_FILE

echo '{"user":'
ldap_to_json
echo '}'
 
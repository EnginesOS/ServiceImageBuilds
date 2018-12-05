#!/bin/sh

 . /home/engines/functions/checks.sh
 
 
if test -z $uid
 then
  echo '{"error":"No uid specified"}'
  exit 127
fi

. /home/engines/scripts/actionators/x400_to_json.sh

/home/engines/scripts/ldap/ldapsearch.sh "ou=People,dc=engines,dc=internal" uid=$uid mailacceptinggeneralid  > $LDAP_FILE

echo '{"email_addresses":'
key=mailacceptinggeneralid
map_ldap_to_json_array
echo '}'



 
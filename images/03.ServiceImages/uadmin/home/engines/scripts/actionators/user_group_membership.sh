#!/bin/sh

 . /home/engines/functions/checks.sh
 
if test -z $uid
 then
  echo '{"error":"No ui specified"}'
  exit 127
fi

. /home/engines/scripts/actionators/x400_to_json.sh

/home/engines/scripts/ldap/ldapsearch.sh "ou=Groups,dc=engines,dc=internal" memberUid=$uid cn > $LDAP_FILE


echo '{"groups":'
key=cn
map_ldap_to_json_array
echo '}'
#!/bin/sh

 . /home/engines/functions/checks.sh
 
if test -z $group_name
 then
  echo '{"error":"No Group Name specified"}'
  exit 127
fi
. /home/engines/scripts/actionators/x400_to_json.sh

/home/engines/scripts/ldap/ldapsearch.sh "ou=Groups,dc=engines,dc=internal" cn=$group_name memberUid > $LDAP_FILE 

echo '{"members":'
key=memberUid
map_ldap_to_json_array
echo '}'
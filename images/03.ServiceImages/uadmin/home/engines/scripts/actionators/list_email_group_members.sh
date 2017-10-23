#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
if test -z $email_group
 then
  echo '{"Result":"FAILED","ErrorMesg":"Missing Group name"}'
  exit 127
fi
 
 
. /home/engines/scripts/actionators/x400_to_json.sh

/home/engines/scripts/ldap/ldapsearch.sh "ou=Distribution Groups,dc=engines,dc=internal" cn=$email_group memberUid > $LDAP_FILE


echo '{"email_addresses":'
key=memberUid
map_ldap_to_json_array
echo '}'
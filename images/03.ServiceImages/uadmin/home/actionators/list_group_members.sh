#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env

. /home/actionators/x400_to_json.sh

x400string=`/home/engines/scripts/ldapsearch -LLL -b "ou=People,dc=engines,dc=internal" -h ldap objectClass=posixAccount`

echo '{"groups":'
ldap_to_json
echo '}'
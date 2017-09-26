#!/bin/bash
#. /home/engines/functions/params_to_env.sh
#parms_to_env

. /home/actionators/x400_to_json.sh

x400string=`/home/engines/scripts/ldapsearch.sh -LLL -b "ou=Groups,dc=engines,dc=internal" -h ldap objectClass=posixGroup cn gidNumber`



echo '{"groups":'
ldap_to_json
echo '}'
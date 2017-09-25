#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env

/home/engines/scripts/ldapsearch -b "ou=People,dc=engines,dc=internal" -h ldap objectClass=posixAccount
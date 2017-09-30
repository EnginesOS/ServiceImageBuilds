#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env

cat /home/templates/add_user.ldif |  while read LINE
do
eval echo $LINE > /tmp/ldif
done

cat /tmp/ldif | /home/engines/scripts/ldapadd.sh -h ldap 
#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env

dn=`/home/engines/scripts/get_dn.sh  ou=People,dc=engines,dc=internal uid=$uid`

rm /tmp/ldif
cat /home/templates/del_user.ldif | while read LINE
do
 eval echo $LINE >> /tmp/ldif
done


cat /tmp/ldif | /home/engines/scripts/ldapmodify.sh 

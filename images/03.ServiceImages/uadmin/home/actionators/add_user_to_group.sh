#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env

rm /tmp/ldif
cat /home/templates/add_user_to_group.ldif | while read LINE
do
 eval echo $LINE >> /tmp/ldif
done


cat /tmp/ldif | /home/engines/scripts/ldapmodify.sh  
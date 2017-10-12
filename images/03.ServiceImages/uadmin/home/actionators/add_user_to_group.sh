#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env

rm $LDIF_FILE
cat /home/templates/add_user_to_group.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done


cat $LDIF_FILE | /home/engines/scripts/ldapmodify.sh  
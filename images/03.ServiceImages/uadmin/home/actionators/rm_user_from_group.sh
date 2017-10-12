#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env

. /home/engines/functions/ldap_support_functions.sh

cat /home/templates/rm_user_from_group.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done


cat $LDIF_FILE | /home/engines/scripts/ldapmodify.sh
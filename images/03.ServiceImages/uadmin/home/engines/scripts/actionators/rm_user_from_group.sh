#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
required_values="uid group_name"
check_required_values 

. /home/engines/functions/ldap/support_functions.sh

cat /home/engines/templates/rm_user_from_group.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done


cat $LDIF_FILE | /home/engines/scripts/ldap/ldapmodify.sh
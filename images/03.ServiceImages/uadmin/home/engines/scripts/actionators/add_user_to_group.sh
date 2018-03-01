#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
required_values="group_name uid"
check_required_values 

. /home/engines/functions/ldap/support_functions.sh

cat /home/engines/templates/add_user_to_group.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done


cat $LDIF_FILE | /home/engines/scripts/ldap/ldapmodify.sh  
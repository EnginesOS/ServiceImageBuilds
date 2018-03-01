#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
required_values="email_address uid"
check_required_values 

. /home/engines/functions/ldap/support_functions.sh

dn=`/home/engines/scripts/ldap/get_dn.sh  ou=People,dc=engines,dc=internal uid=$uid`


cat /home/engines/templates/add_email_to_user.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done


cat $LDIF_FILE | /home/engines/scripts/ldap/ldapmodify.sh 

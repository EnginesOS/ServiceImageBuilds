#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
dn=`/home/engines/scripts/ldap/get_dn.sh  ou=People,dc=engines,dc=internal uid=$uid`

. /home/engines/functions/ldap/support_functions.sh

cat /home/engines/templates/del_user_email.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done


cat $LDIF_FILE | /home/engines/scripts/ldap/ldapmodify.sh 

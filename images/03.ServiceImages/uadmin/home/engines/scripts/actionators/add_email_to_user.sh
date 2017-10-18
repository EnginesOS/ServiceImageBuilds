#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

. /home/engines/functions/ldap_support_functions.sh

dn=`/home/engines/scripts/get_dn.sh  ou=People,dc=engines,dc=internal uid=$uid`


cat /home/engines/templates/add_email_to_user.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done


cat $LDIF_FILE | /home/engines/scripts/ldapmodify.sh 

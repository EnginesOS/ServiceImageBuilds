#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

. /home/engines/functions/ldap/support_functions.sh

cat /home/engines/templates/rm_email_group.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done


cat $LDIF_FILE | /home/engines/scripts/ldap/ldapmodify.sh 

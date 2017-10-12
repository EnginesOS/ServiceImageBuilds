#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env
dn=`/home/engines/scripts/get_dn.sh  ou=People,dc=engines,dc=internal uid=$uid`

rm $LDIF_FILE
cat /home/templates/add_email_to_user.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done


cat $LDIF_FILE | /home/engines/scripts/ldapmodify.sh 

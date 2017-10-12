#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env
. /home/engines/functions/ldap_support_functions.sh

cat /home/templates/add_user.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done

uidnumber=`/home/engines/scripts/next_uid.sh`

echo uidnumber:$uidnumber >> $LDIF_FILE

cat $LDIF_FILE | /home/engines/scripts/ldapadd.sh 
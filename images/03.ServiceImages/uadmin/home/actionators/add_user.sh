#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env
rm /tmp/ldif
cat /home/templates/add_user.ldif | while read LINE
do
 eval echo $LINE >> /tmp/ldif
done

uidnumber=`/home/engines/scripts/next_uid.sh`

echo uidnumber:$uidnumber >> /tmp/ldif

cat /tmp/ldif | /home/engines/scripts/ldapadd.sh 
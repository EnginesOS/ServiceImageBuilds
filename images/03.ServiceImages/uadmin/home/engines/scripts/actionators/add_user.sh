#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
. /home/engines/functions/ldap/support_functions.sh

cat /home/engines/templates/add_user.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done

uidnumber=`/home/engines/scripts/ldap/next_uid.sh`

echo uidnumber:$uidnumber >> $LDIF_FILE

r=`cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh` 
if test $? -eq 0
 then
  echo "addprinc -pw $password  $uid" | sudo -n /home/engines/scripts/actionators/sudo/_add_kerberos_princ.sh
fi   
e=$?
if test $e -eq 0
 then
   echo $r
 else
   echo '{"Error":"failed to add k user","Result":"Failed","exit":"'$e'"}'   
 fi
   
#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

. /home/engines/functions/ldap/support_functions.sh

dn=`/home/engines/scripts/get_dn.sh  ou=People,dc=engines,dc=internal uid=$uid`

cat /home/engines/templates/del_user.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done


r=`cat $LDIF_FILE | /home/engines/scripts/ldap/ldapmodify.sh` 
if test $? -eq 0
 then
  echo "delprinc -force  $uid" | sudo -n /home/engines/scripts/actionators/sudo/_add_kerberos_princ.sh
fi   
e=$?
if test $e -eq 0
 then
   echo $r
 else
   echo '{"Error":"failed to del k user","Result":"Failed","exit":"'$e'"}'   
 fi
   

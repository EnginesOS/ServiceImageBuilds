#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
. /home/engines/functions/ldap/support_functions.sh
required_values="uid password last_name given_name domain_name"
check_required_values 

cat /home/engines/templates/add_user.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done

uidnumber=`/home/engines/scripts/ldap/next_uid.sh`

echo uidnumber:$uidnumber >> $LDIF_FILE
err_file=`mktemp`
r=`cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh` 
if test $? -eq 0
 then
  echo "addprinc -pw $password  $uid" | sudo -n /home/engines/scripts/actionators/sudo/_add_kerberos_princ.sh &> $err_file
fi   
e=$?
if test $e -eq 0
 then
   echo $r
 else
   echo '{"uid":"'$uid'"}' | /home/engines/scripts/actionators/del_user.sh   
    mesg=`cat $err_file`
   echo '{"Error":"failed to add k user","Result":"Failed","exit":"'$e',"mesg":"'$mesg'"}'   
 fi
  
rm  $err_file
   
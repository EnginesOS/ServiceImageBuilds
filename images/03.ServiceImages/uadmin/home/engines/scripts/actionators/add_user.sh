#!/bin/sh

 . /home/engines/functions/checks.sh
 
. /home/engines/functions/ldap/support_functions.sh
required_values="uid password last_name given_name default_domain"
check_required_values 
echo  $password > /tmp/pas
echo -n $password  | openssl dgst -sha1 -binary | openssl enc -base64 > /tmp/np_p
shapass=`echo -n $password  | openssl dgst -sha1 -binary | openssl enc -base64`
cat /home/engines/templates/add_user.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done

uidnumber=`/home/engines/scripts/ldap/next_uid.sh`

echo uidnumber:$uidnumber >> $LDIF_FILE
err_file=`mktemp`
r=`cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh` 
#if test $? -eq 0
# then
#  echo "addprinc -pw $password  $uid" | sudo -n /home/engines/scripts/actionators/sudo/_add_kerberos_princ.sh &> $err_file
#fi   
#e=$?
#if test $e -eq 0
# then
#   echo $r
# else
#   echo '{"uid":"'$uid'"}' | /home/engines/scripts/actionators/del_user.sh   
#    mesg=`cat $err_file`
#   echo '{"Error":"failed to add k user","Result":"Failed","exit":"'$e',"mesg":"'$mesg'"}'   
# fi
  
rm  $err_file
   
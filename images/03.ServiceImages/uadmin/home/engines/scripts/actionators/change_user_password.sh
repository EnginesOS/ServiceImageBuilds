#!/bin/sh

 . /home/engines/functions/checks.sh
 
required_values="uid password"
check_required_values 

shapass=`echo -n $password  | openssl dgst -sha1 -binary | openssl enc -base64`
. /home/engines/functions/ldap/support_functions.sh
cn=`/home/engines/scripts/ldap/ldapsearch.sh   ou=People,dc=engines,dc=internal uid=$uid cn |grep ^cn | sed "s/cn: //"`
export cn

cat /home/engines/templates/chg_user_pass.ldif | while read LINE
do
 eval echo "$LINE" >> $LDIF_FILE
done
err=`/home/engines/scripts/ldap/ldapmodify.sh -f $LDIF_FILE ` 
rm $LDIF_FILE 
e=$?
 if test $e -eq 0
 then
   echo '{"Result":"OK","Code":"200"}'
 else
   echo '{"Error":"failed to change user","Result":"Failed '$err'","exit":"'$r'"}'   
 fi

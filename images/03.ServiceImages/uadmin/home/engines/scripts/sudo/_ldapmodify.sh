#/bin/bash

kinit -kt /etc/krb5kdc/keys/uadmin.keytab 
/usr/bin/ldapmodify -h ldap $* &> /tmp/ldap.mod.out
ldap_result=$?
export ldap_result
if test $ldap_result -eq 0
 then
  echo '{"Result":"OK","ReturnCode",0}'
  else
   err=`cat /tmp/ldap.add.out`
   echo  '{"Result":"FAIL","ReturnCode":"'$ldap_result'":"Output":"'$err'"}'
 fi
kdestroy
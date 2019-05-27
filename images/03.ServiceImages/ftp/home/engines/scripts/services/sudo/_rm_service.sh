#!/bin/bash

kinit -t /etc/krb5kdc/keys/ftp.keytab 
dn="cn=$service_handle,ou=ftp,ou=Services,ou=Containers,ou=Engines,dc=engines,dc=internal"

uid=`ldapsearch -h ldap "$dn" |grep -i uid: | awk '{print $2'}`
exit_code=$?

if test $exit_code -eq 0 
 then 
   ldapdelete "$dn" -H ldap://ldap/
   exit_code=$?  
    if test $exit_code -eq 0 
     then 
      /home/engines/scripts/services/del_from_ftp_group.sh $uid
      exit_code=$?
    else
      echo "Failed to delete $uid"
      exit_code=2
    fi
else
  exit_code=2
  echo "$dn Not Found" 
fi
#dont leave ticket open
kdestroy
exit $exit_code
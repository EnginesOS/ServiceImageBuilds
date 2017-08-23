#!/bin/bash


. /home/engines/functions/params_to_env.sh
parms_to_env
set > /tmp/full_env
kinit -t /etc/krb5kdc/keys/ftp.keytab 




dn="cn=$service_handle,ou=ftp,ou=Service accounts,dc=engines,dc=internal"
uid=`ldapsearch "$dn" |grep -i uidnumber: | awk '{print $2'}`
ldapdelete "$dn" -H ldap://ldap/
 
/home/del_from_ftp_group.sh $uid
 #dont leave ticket open
kdestroy
  

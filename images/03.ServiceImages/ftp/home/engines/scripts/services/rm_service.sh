#!/bin/bash


. /home/engines/functions/params_to_env.sh
params_to_env
set > /tmp/full_env
kinit -t /etc/krb5kdc/keys/ftp.keytab 

required_values="service_handle"
check_required_values


dn="cn=$service_handle,ou=ftp,ou=Service Accounts,ou=Engines,dc=engines,dc=internal"
uid=`ldapsearch "$dn" |grep -i uid: | awk '{print $2'}`
ldapdelete "$dn" -H ldap://ldap/
 
/home/engines/scripts/services/del_from_ftp_group.sh $uid
 #dont leave ticket open
kdestroy
  

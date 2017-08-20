#!/bin/bash


. /home/engines/functions/params_to_env.sh
parms_to_env
set > /tmp/full_env
kinit -t /etc/krb5kdc/keys/ftp.keytab 

dn="cn=$service_handle,ou=ftp,ou=Service accounts,dc=engines,dc=internal"
ldapdelete "$dn" -H ldap://ldap/
 
 #dont leave ticket open
 kdestroy
  

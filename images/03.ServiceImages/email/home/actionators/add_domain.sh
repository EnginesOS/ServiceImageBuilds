#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z $domain_name
 then
  echo '{"error":"Missing $domain_name"}'
  exit 127
fi
 kinit -t /etc/krb5kdc/keys/email.keytab 

cat /home/actionators/tmpls/add_domain.ldif | sed "/DOMAIN/s//$domain_name/" | ldapadd -h ldap

 
 result=$?
 
 kdestroy
 
 exit $result 
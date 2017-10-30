#!/bin/bash


. /home/engines/functions/params_to_env.sh
params_to_env
set > /tmp/full_env
kinit -t /etc/krb5kdc/keys/ldap.keytab 

dn=cn=$cn,ou=$parent_engine,ou=$container_types,ou=Groups,dc=engines,dc=internal"
dn="ou=$parent_engine,ou=$container_types,ou=Groups,dc=engines,dc=internal"


kdestroy
  

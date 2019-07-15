#!/bin/sh

kinit -kt /etc/krb5kdc/keys/ldap.keytab
pid=`cat /home/engines/run/slapd.pid`

ldapdelete  -r "ou=People,dc=engines,dc=internal"
ldapdelete  -r "ou=Engines,dc=engines,dc=internal"
ldapdelete  -r "ou=Distribution Groups,dc=engines,dc=internal"
ldapdelete  -r "ou=Group,dc=engines,dc=internal"

 kill -TERM $pid
 kill -0 $pid
 while test $? eq 0
  do
    sleep 5
    kill -0 $pid
 done
    
cat - | slapadd -v -c 
result=$?

kdestroy



exit $result

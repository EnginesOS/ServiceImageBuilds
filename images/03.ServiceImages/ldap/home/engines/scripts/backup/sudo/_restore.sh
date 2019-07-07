#!/bin/sh

kinit -kt /etc/krb5kdc/keys/ldap.keytab
pid=`cat /home/engines/run/slapd.pid`
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

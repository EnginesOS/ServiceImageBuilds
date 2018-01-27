#!/bin/bash

. /home/engines/functions/system_functions.sh


export KRB5_KTNAME=/etc/krb5kdc/keys/ldap.keytab

saslauthd -a kerberos5 -d &> /tmp/sas.log &

ulimit -n 1024 
/usr/sbin/slapd -d 160  -h "ldap://0.0.0.0/  ldapi:///"&
pid=$!


  
if ! test -f /home/engines/run/flags/init_ous_configured
 then
# sleep 1000 # debug
 sleep 10 # allow server to start
  /home/engines/scripts/first_run/init_ous_configured.sh
   if test $? -eq 0
    then
     touch /home/engines/run/flags/init_ous_configured
   fi
fi  

echo -n " $pid " >> /tmp/pids
chmod g+x /tmp/pids
chgrp containers /tmp/pids

fg





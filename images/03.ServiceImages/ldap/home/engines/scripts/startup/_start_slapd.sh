#!/bin/bash



export KRB5_KTNAME=/etc/krb5kdc/keys/ldap.keytab

saslauthd -a kerberos5 -d &> /tmp/sas.log &

ulimit -n 1024 
/usr/sbin/slapd -d 160  -h "ldap://0.0.0.0/  ldapi:///"&
pid=$!

#touch /engines/var/run/flags/init_ous_configured
  
if ! test -f /engines/var/run/flags/init_ous_configured
 then
# sleep 1000 # debug
 sleep 10 # allow server to start
  /home/engines/scripts/first_run/init_ous_configured.sh
   if test $? -eq 0
    then
     touch /engines/var/run/flags/init_ous_configured
   fi
fi  

echo -n " $pid " >> /tmp/pids
chmod g+x /tmp/pids
chgrp containers /tmp/pids

touch /engines/var/run/flags/startup_complete
wait $pid
exit_code=$?
rm /engines/var/run/flags/startup_complete  
kill `cat /tmp/pids`


exit $exit_code
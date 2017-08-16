#!/bin/bash



export KRB5_KTNAME=/etc/krb5kdc/keys/ldap.keytab

saslauthd -a kerberos5 -d &> /tmp/sas.log &

ulimit -n 1024 
/usr/sbin/slapd -d 225  -h "ldap://0.0.0.0/  ldapi:///"&
pid=$!

 #touch /engines/var/run/flags/init_ous_configured
  
if ! test -f /engines/var/run/flags/init_ous_configured
 then
 sleep 10
  /home/init_ous_configured.sh
   if test $? -eq 0
    then
     touch /engines/var/run/flags/init_ous_configured
     mv /usr/lib/sasl2/sasl2_slapd.conf /usr/lib/sasl2/slapd.conf
     sleep 1
     kill $pid
   fi
fi  

echo -n " $pid " >> /tmp/pids
chmod g+x /tmp/pids
chgrp containers /tmp/pids

touch /engines/var/run/flags/startup_complete
wait $pid
exit_code=$?

kill `cat /tmp/pids`

rm /engines/var/run/flags/startup_complete  

exit $exit_code
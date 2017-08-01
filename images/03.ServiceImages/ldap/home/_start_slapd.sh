#!/bin/bash
ulimit -n 1024 
/usr/sbin/slapd -d 4  -h "ldap://0.0.0.0/  ldapi:///"&
pid=$!
  
if ! test -f /engines/var/run/flags/kerobos_configured
 then
  /home/configure_kerobos.sh
   if test $? -eq 0
    then
     touch /engines/var/run/flags/kerobos_configured
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
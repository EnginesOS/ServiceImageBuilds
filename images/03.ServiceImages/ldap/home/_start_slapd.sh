#!/bin/bash
ulimit -n 1024 
/usr/sbin/slapd -d 4 &
pid=$!

echo -n " $pid " >> /tmp/pids
chmod g+x /tmp/pids
chgrp containers /tmp/pids

touch /engines/var/run/flags/startup_complete
wait $pid
exit_code=$?

kill `cat /tmp/pids`

rm /engines/var/run/flags/startup_complete  

exit $exit_code
#!/bin/bash

if test -f /var/spool/postfix/pid/master.pid
 then
	rm /var/spool/postfix/pid/master.pid
 fi

/usr/lib/postfix/sbin/master -w
r=$?
if test $r -eq 0
 then
	sleep 5	
 else
  echo "Failed with $r"
  exit $r	  
fi
touch  /engines/var/run/flags/startup_complete

while test -f /var/spool/postfix/pid/master.pid
 do
  sleep 3600 &
  echo $! > /tmp/sleep.pid
  wait
done 


rm /engines/var/run/flags/startup_complete  
/home/engines/scripts/signal/_kill_postfix.sh
/home/engines/scripts/signal/_kill_syslog.sh

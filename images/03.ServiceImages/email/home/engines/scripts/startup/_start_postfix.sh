#!/bin/bash

rm /var/spool/postfix/pid/master.pid
/usr/lib/postfix/sbin/master -w
r=$?
if test $r -eq 0
 then
	sleep 5	
 else
  echo "Failed with $r"
  exit $r	  
fi
touch  /home/engines/run/flags/startup_complete

while test -f /var/spool/postfix/pid/master.pid
 do
  sleep 3600 &
  echo $! > /tmp/sleep.pid
  wait
  echo sleep dead
done 


rm /home/engines/run/flags/startup_complete  
/home/engines/scripts/signal/_kill_postfix.sh


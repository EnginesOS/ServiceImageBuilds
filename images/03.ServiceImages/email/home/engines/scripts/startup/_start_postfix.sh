#!/bin/bash
. /home/engines/functions/system_functions.sh

rm /var/spool/postfix/pid/master.pid
/usr/lib/postfix/sbin/master -w
chgrp containers /var/spool/postfix/pid/master.pid
chmod g+r /var/spool/postfix/pid/master.pid
r=$?
if test $r -eq 0
 then
	sleep 5	
 else
  echo "Failed with $r"
  exit $r	  
fi

startup_complete

while test -f /var/spool/postfix/pid/master.pid
 do
  sleep 3600 &
  echo $! > /tmp/sleep.pid
  chgrp containers /tmp/sleep.pid
  chmod g+w /tmp/sleep.pid
  wait
  echo sleep dead
   if test -f /tmp/sleep.pid
    then
  		rm /tmp/sleep.pid
  	fi
done 
/home/engines/scripts/signal/_kill_postfix.sh

shutdown_complete




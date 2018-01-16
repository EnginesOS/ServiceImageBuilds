#!/bin/bash
. /home/engines/functions/system_functions.sh

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

startup_complete

while ! test -f /home/engines/run/flags/sig_term -o -f /home/engines/run/flags/sig_quit
 do 
    sleep 3600 &
    echo $! >/tmp/sleep.pid
	wait 		
	exit_code=$?		
done	

/home/engines/scripts/signal/_kill_postfix.sh

shutdown_complete




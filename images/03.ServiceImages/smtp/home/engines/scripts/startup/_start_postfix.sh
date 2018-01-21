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
    startup_complete
	sleep 5	
 else
  echo "Failed with $r"
  exit $r	  
fi


while ! test -f /home/engines/run/flags/sig_term -o -f /home/engines/run/flags/sig_quit
 do 
    sleep 120 &
    echo $! >/tmp/sleep.pid
	wait 		
	exit_code=$?		
done	

shutdown_complete



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
touch  /engines/var/run/flags/startup_complete

wait `cat /var/spool/postfix/pid/master.pid`
exit_code=$?

rm /engines/var/run/flags/startup_complete  
/home/engines/scripts/_kill_syslog.sh
exit $exit_code

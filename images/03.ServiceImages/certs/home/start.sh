#!/bin/sh


PID_FILE=/tmp/.pid
export PID_FILE
. /home/engines/functions/trap.sh


touch /engines/var/run/flags/startup_complete
	while test 4 -ne 3
	do 
	    sleep 500 &
	    echo $! >/tmp/.pid
		wait 
		exit_code=$?
	done	

rm -f /engines/var/run/flags/startup_complete
exit $exit_code

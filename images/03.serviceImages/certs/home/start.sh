#!/bin/sh


PID_FILE=/home/certs/.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/



touch /engines/var/run/flags/startup_complete
	while test 4 -ne 3
	do 
	    sleep 500 &
	    echo $! >/home/certs/.pid
		wait 
	done	

rm -f /engines/var/run/flags/startup_complete

#!/bin/sh

PID_FILE=/tmp/sleep.pid
export PID_FILE
. /home/engines/functions/trap.sh

startup_complete

	while test 4 -ne 3
	do 
	    sleep 500 &
	    echo $! >/tmp/sleep.pid
		wait 
		exit_code=$?
	done	

shutdown_complete

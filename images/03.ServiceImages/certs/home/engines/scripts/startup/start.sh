#!/bin/sh

PID_FILE=/home/engines/run/sleep.pid
export PID_FILE
. /home/engines/functions/trap.sh


startup_complete

	while ! test -f /home/engines/run/flags/sig_term -o -f /home/engines/run/flags/sig_quit
	do 
	    sleep 500 &
	    echo $! >$PID_FILE
		wait 		
		exit_code=$?		
	done	

shutdown_complete

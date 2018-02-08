#!/bin/sh

PID_FILE=/tmp/pid
export PID_FILE
. /home/engines/functions/trap.sh

startup_complete

while ! test -f /home/engines/run/flags/sig_term -o -f /home/engines/run/flags/sig_quit
 do 
    sleep 120 &
    echo $! >/tmp/sleep.pid
	wait 		
	exit_code=$?		
done

shutdown_complete

#!/bin/sh

PID_FILE=/home/engines/run/pid
export PID_FILE
. /home/engines/functions/trap.sh

startup_complete

c=1

while ! test -f /home/engines/run/flags/sig_term -o -f /home/engines/run/flags/sig_quit
	do 
      sleep 3600 &
      echo $! > $PID_FILE
      wait
     exit_code=$?	
done

shutdown_complete
	
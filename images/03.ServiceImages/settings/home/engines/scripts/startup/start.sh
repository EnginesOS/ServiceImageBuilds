#!/bin/sh

PID_FILE=/home/engines/run/sleep.pid
export PID_FILE
. /home/engines/functions/trap.sh

/home/engines/scripts/engine/deploy.sh
  	
sleep 500 &
echo $! > $PID_FILE
startup_complete
wait

shutdown_complete

#!/bin/sh

PID_FILE=/tmp/sleep.pid
export PID_FILE
. /home/engines/functions/trap.sh
 sleep 400

startup_complete
/usr/bin/freeradius  -fX &
wait
exit_code=$?

shutdown_complete


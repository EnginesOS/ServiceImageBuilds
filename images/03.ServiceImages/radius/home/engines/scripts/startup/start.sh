#!/bin/sh

PID_FILE=/home/engines/run/freeradius.pid
export PID_FILE
. /home/engines/functions/trap.sh

startup_complete
/usr/sbin/freeradius  -fX &
wait
exit_code=$?

shutdown_complete


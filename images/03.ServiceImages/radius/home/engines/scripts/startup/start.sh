#!/bin/sh

PID_FILE=/tmp/sleep.pid
export PID_FILE
. /home/engines/functions/trap.sh


startup_complete
sudo /usr/sbin/freeradius  -fX &
wait
exit_code=$?

shutdown_complete


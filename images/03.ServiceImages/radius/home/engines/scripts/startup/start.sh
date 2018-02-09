#!/bin/sh

PID_FILE=/tmp/sleep.pid
export PID_FILE
. /home/engines/functions/trap.sh


startup_complete
sudo /usr/bin/freeradius  &
wait
exit_code=$?
sleep 500
shutdown_complete


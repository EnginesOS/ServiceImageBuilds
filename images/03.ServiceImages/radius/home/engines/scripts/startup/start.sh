#!/bin/sh

PID_FILE=/home/engines/run/freeradius.pid
export PID_FILE
. /home/engines/functions/trap.sh

startup_complete

sudo -n /home/engines/scripts/startup/_setup_clients.sh

/usr/sbin/freeradius  -fX &
wait
exit_code=$?

shutdown_complete


#!/bin/sh

PID_FILE=/home/engines/run/master.pid
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/stop_samba.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

service_first_run_check

sleep 600 &
echo $! > $PID_FILE

startup_complete

wait
exit_code=$?

shutdown_complete

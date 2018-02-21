#!/bin/sh

PID_FILE=/var/run/starter.charon.pid
export PID_FILE
KILL_SCRIPT=/home/engines/scripts/signal/shutdown.sh

export KILL_SCRIPT
. /home/engines/functions/trap.sh

service_first_run_check


sudo -n /home/engines/scripts/startup/_start.sh & 



startup_complete 

wait
exit_code=$?

shutdown_complete


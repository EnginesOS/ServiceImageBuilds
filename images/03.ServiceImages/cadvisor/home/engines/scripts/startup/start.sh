#!/bin/sh


KILL_SCRIPT=/home/engines/scripts/signal/kill_bind.sh
export KILL_SCRIPT


PID_FILE=/home/engines/run/cadvisor.pid
export PID_FILE
. /home/engines/functions/trap.sh



startup_complete

sleep 300 &

exit_code=$?

shutdown_complete


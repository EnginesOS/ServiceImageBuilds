#!/bin/sh
  
PID_FILE=/home/engines/run/shibboleth.pid
export PID_FILE
. /home/engines/functions/trap.sh

service_first_run_check

sleep 36000&
echo $! > $PID_FILE



startup_complete

wait
exit_code=$?

shutdown_complete

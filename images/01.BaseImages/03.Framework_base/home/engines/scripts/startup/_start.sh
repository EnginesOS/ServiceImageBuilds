#!/bin/sh

rm -f /home/engines/run/startup_complete

PID_FILE=/home/engines/run/engines.pid	

export PID_FILE

. /home/engines/functions/trap.sh

. /home/engines/functions/start_functions.sh

volume_setup
dynamic_persistence

first_run

restart_required

custom_start
  
framework_start

blocking

startup_complete
wait 
exit_code=$?
sleep 30
shutdown_complete
exit $exit_code

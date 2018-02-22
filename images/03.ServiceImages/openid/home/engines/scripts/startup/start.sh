#!/bin/sh
  
PID_FILE=/home/engines/run/apache.pid
export PID_FILE
. /home/engines/functions/trap.sh

service_first_run_check
export APACHE_PID_FILE $PID_FILE
/usr/sbin/apache2ctl -DFOREGROUND &	



startup_complete

wait
exit_code=$?

shutdown_complete

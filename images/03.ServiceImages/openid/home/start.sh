#!/bin/sh
  
PID_FILE=/var/run/engines/apache.pid
export PID_FILE
. /home/engines/functions/trap.sh

service_first_run_check

/usr/sbin/apache2ctl -DFOREGROUND &	

echo $? > /var/run/engines/apache.pid

startup_complete

wait
exit_code=$?

shutdown_complete

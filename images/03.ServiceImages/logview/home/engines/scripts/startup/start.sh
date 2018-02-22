#!/bin/sh

PID_FILE=/home/engines/run/apache.pid
#/home/scripts/services/build_config.sh
export PID_FILE
. /home/engines/functions/trap.sh
mkdir -p /var/log/log_viewer
export APACHE_PID_FILE=$PID_FILE
/usr/sbin/apache2ctl  -DFOREGROUND &

startup_complete
  
wait 
exit_code=$?

shutdown_complete

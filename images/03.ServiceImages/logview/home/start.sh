#!/bin/sh

PID_FILE=/var/run/apache.pid
/home/build_config.sh
export PID_FILE
. /home/engines/functions/trap.sh
mkdir -p /var/log/log_viewer


/usr/sbin/apache2ctl  -DFOREGROUND &

touch /home/engines/run/flags/startup_complete  
wait 
exit_code=$?
rm -f /home/engines/run/flags/startup_complete

exit $exit_code


 
 


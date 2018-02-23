#!/bin/sh

PID_FILE=/home/engines/run/syslog.pid
export PID_FILE
. /home/engines/functions/trap.sh
 
sudo -n  syslog-ng -F -f /etc/syslog-ng/syslog-ng.conf -p $PID_FILE --no-caps  -v -e &

startup_complete

wait  
exit_code=$?
/home/engines/scripts/signal/_signal.sh
shutdown_complete


#!/bin/sh


PID_FILE=/var/run/ftpd.pid
export PID_FILE
. /home/engines/functions/trap.sh


sudo -n  /usr/sbin/proftpd -n &

startup_complete

wait 
exit_code=$?

shutdown_complete

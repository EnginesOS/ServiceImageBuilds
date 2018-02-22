#!/bin/sh
PID_FILE=/home/engines/run/logrotate.pid
export PID_FILE
. /home/engines/functions/trap.sh

startup_complete

sleep 120
echo "Log Rotated Started"
date




sudo /usr/sbin/logrotate -f /home/logrotate.conf &
pid=$!
echo $pid >$PID_FILE

wait  
exit_code=$?
echo "Log Rotated Completed"
date

shutdown_complete





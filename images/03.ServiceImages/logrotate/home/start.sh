#!/bin/sh

startup_complete

sleep 120
echo "Log Rotated Started"
date

PID_FILE=/tmp/logrotate.pid
export PID_FILE
. /home/engines/functions/trap.sh


sudo /usr/sbin/logrotate -f /home/logrotate.conf &
pid=$!
echo $pid >$PID_FILE

wait  
exit_code=$?
echo "Log Rotated Completed"
date

shutdown_complete





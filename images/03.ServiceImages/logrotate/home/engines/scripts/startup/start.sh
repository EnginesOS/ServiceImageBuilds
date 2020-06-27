#!/bin/sh
PID_FILE=/home/engines/run/logrotate.pid
export PID_FILE
. /home/engines/functions/trap.sh

startup_complete

sleep 120

date

sudo /usr/sbin/logrotate -f /home/logrotate.conf &
echo "Log Rotated Started"
pid=$!
echo $pid >$PID_FILE

wait  
exit_code=$?
echo "Log Rotated Completed"
date

shutdown_complete





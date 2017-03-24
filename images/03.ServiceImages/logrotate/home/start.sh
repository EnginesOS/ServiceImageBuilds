#!/bin/sh

echo "Log Rotated Started"
date

PID_FILE=/tmp/logrotate.pid
export PID_FILE
. /home/trap.sh
mkdir -p /engines/var/run/flags/

sudo /usr/sbin/logrotate -f /home/logrotate.conf &
pid=$!
echo $pid >$PID_FILE
touch  /engines/var/run/flags/startup_complete
wait  
echo "Log Rotated Completed"
date

rm /engines/var/run/flags/startup_complete





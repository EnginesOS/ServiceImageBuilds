#!/bin/sh

PID_FILE=/var/run/logrotate.pid
export PID_FILE
. /home/trap.sh
mkdir -p /engines/var/run/flags/

/usr/sbin/logrotate -f /home/logrotate.conf &
pid=$%
echo $pid >$PID_FILE


touch  /engines/var/run/flags/startup_complete
wait  
rm /engines/var/run/flags/startup_complete



sleep 3600

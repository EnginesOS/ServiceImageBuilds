#!/bin/sh
touch  /home/engines/run/flags/startup_complete
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

rm /home/engines/run/flags/startup_complete

exit $exit_code




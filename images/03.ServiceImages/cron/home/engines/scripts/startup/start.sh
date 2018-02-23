#!/bin/sh


PID_FILE=/home/engines/run/fcron.pid
export PID_FILE
. /home/engines/functions/trap.sh

/home/cron/sbin/fcron -f -p  /home/cron/log/cron.log &

startup_complete

wait 
exit_code=$?

shutdown_complete

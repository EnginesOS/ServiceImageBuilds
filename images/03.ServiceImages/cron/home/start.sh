#!/bin/sh


PID_FILE=/home/cron/fcron.pid
export PID_FILE
. /home/engines/functions/trap.sh


/home/cron/sbin/fcron -f -p  /home/cron/log/cron.log &
touch /home/engines/run/flags/startup_complete  
wait 
exit_code=$?

rm -f /home/engines/run/flags/startup_complete
exit $exit_code

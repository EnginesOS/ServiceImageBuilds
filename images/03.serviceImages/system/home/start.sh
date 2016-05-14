#!/bin/sh

pid=$$
echo $pid >/tmp/pid
PID_FILE=/engines/var/run/system.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/

cd /home/


thin   -C config.yaml -R ./config.ru start > /var/log/system.log


touch /engines/var/run/flags/startup_complete  
wait 
kill -TERM  $pid
rm -f /engines/var/run/flags/startup_complete


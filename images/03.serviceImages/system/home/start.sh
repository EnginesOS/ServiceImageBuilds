#!/bin/sh


PID_FILE=/engines/var/run/system.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/

cd /home/

cd /opt/engines/
 yard server &
 yard_pid=$!
/usr/local/rbenv/versions/2.3.0/bin/thin    -C config.yaml -R ./config.ru start > /var/log/system.log


touch /engines/var/run/flags/startup_complete  
wait 
kill -TERM  $pid $yard_pid
rm -f /engines/var/run/flags/startup_complete


#!/bin/sh


control_ip=`netstat -rn |grep ^0.0.0 | awk '{print $2}'`
echo $control_ip > /engines/var/run/control_ip
export control_ip 
PID_FILE=/engines/var/run/firstrun.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/

cd /home/app


/usr/local/rbenv/versions/2.3.0/bin/thin    -C config.yaml -R ./config.ru start > /var/log/firstrun.log &


touch /engines/var/run/flags/startup_complete  
wait 
kill -TERM  `cat /engines/var/run/firstrun.pid`
rm -f /engines/var/run/flags/startup_complete


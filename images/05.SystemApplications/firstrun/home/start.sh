#!/bin/sh


SYSTEM_IP=`netstat -rn |grep ^0.0.0 | awk '{print $2}' | tr -d '\n'`
echo $SYSTEM_IP > /engines/var/run/control_ip
export SYSTEM_IP 
PID_FILE=/engines/var/run/firstrun.pid
export PID_FILE
. /home/engines/functions/trap.sh


mkdir -p /engines/var/run/flags/

cd /home/app

/home/deployment.sh

bundle exec thin  -R ./config.ru start > /var/log/firstrun.log &


touch /engines/var/run/flags/startup_complete  
wait 
kill -TERM  `cat /engines/var/run/firstrun.pid`
rm -f /engines/var/run/flags/startup_complete



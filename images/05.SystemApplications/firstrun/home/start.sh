#!/bin/sh


SYSTEM_IP=`netstat -rn |grep ^0.0.0 | awk '{print $2}' | tr -d '\n'`
echo $SYSTEM_IP > /home/engines/run/control_ip
export SYSTEM_IP 
PID_FILE=/home/engines/run/firstrun.pid
export PID_FILE
. /home/engines/functions/trap.sh

cd /home/app

/home/engines/scripts/engine/deployment.sh

bundle exec thin  -R ./config.ru start > /var/log/firstrun.log &

touch /home/engines/run/flags/startup_complete  
wait 
exit_code=$?
kill -TERM  `cat /home/engines/run/firstrun.pid`
rm -f /home/engines/run/flags/startup_complete
exit $exit_code



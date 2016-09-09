#!/bin/sh

/home/clear_flags.sh
control_ip=`netstat -rn |grep ^0.0.0 | awk '{print $2}'`
echo $control_ip > /engines/var/run/control_ip
export control_ip 
PID_FILE=/engines/var/run/system.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/

cd /home/

cd /opt/engines/

 cd /home
/usr/local/rbenv/versions/2.3.0/bin/thin    -C config.yaml -R ./config.ru start > /var/log/system.log &


touch /engines/var/run/flags/startup_complete  
wait 
kill -TERM  `cat $PID_FILE`
rm -f /engines/var/run/flags/startup_complete


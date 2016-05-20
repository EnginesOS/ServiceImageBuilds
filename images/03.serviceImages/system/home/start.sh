#!/bin/sh

/home/clear_flags.sh
ip=`netstat -rn |grep ^0.0.0 | awk '{print $2}'`
cat $ip > /engines/var/run/contro_ip
export control_ip $ip
PID_FILE=/engines/var/run/system.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/

cd /home/

cd /opt/engines/
 /usr/local/rbenv/versions/2.3.0/bin/yard server &
 yard_pid=$!
 cd /home
/usr/local/rbenv/versions/2.3.0/bin/thin    -C config.yaml -R ./config.ru start > /var/log/system.log &


touch /engines/var/run/flags/startup_complete  
wait 
kill -TERM  $pid $yard_pid
rm -f /engines/var/run/flags/startup_complete


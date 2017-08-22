#!/bin/sh


PID_FILE=/var/run/apache.pid
export PID_FILE
. /home/engines/functions/trap.sh

mkdir /var/log/apache2
mkdir /var/run/apache2
  
 

/usr/sbin/apache2ctl -DFOREGROUND &	

echo $? > /var/run/apache.pid
touch  /engines/var/run/flags/startup_complete

wait
exit_code=$?
sleep 3600	
rm /engines/var/run/flags/startup_complete
exit $exit_code
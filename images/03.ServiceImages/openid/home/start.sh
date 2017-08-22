#!/bin/sh


PID_FILE=/var/run/nginx/nginx.pid
export PID_FILE
. /home/engines/functions/trap.sh

mkdir /var/log/apache2
mkdir /var/run/apache2
  
 
sleep 3600 &

touch  /engines/var/run/flags/startup_complete

wait
exit_code=$?
	
rm /engines/var/run/flags/startup_complete
exit $exit_code
#!/bin/sh

rm /etc/nginx/sites-enabled/http*  &> /dev/null
PID_FILE=/var/run/nginx/nginx.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/

/usr/sbin/nginx &


touch  /engines/var/run/flags/startup_complete

		wait
	
rm /engines/var/run/flags/startup_complete
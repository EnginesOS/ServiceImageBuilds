#!/bin/sh

if ! test -d /var/log/nginx
 then
  mkdir -p  /var/log/nginx
fi
	
PID_FILE=/var/run/nginx/nginx.pid
export PID_FILE
. /home/engines/functions/trap.sh

/home/engines/scripts/engine/clear_broken.sh

/usr/sbin/nginx &

startup_complete

wait
exit_code=$?
	
shutdown_complete

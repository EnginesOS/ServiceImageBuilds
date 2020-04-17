#!/bin/sh

rm -f /home/engines/run/startup_complete

PID_FILE=/home/engines/run/engines.pid	

export PID_FILE

. /home/engines/functions/trap.sh

. /home/engines/functions/start_functions.sh

volume_setup
dynamic_persistence

first_run

restart_required

pre_running

custom_start
 
framework_start

blocking

#for non apache framework (or use custom start)
if test -f /home/engines/scripts/start/startwebapp.sh 
 then
   launch_app
elif test -f /usr/sbin/apache2ctl
 then
   export APACHE_PID_FILE=$PID_FILE
   start_apache
elif test -d /etc/nginx
 then
   start_nginx	
fi

startup_complete
wait 
exit_code=$?
shutdown_complete
exit $exit_code

#!/bin/sh

PID_FILE=/var/run/apache.pid
/home/build_config.sh
export PID_FILE
. /home/engines/functions/trap.sh
mkdir -p /var/log/log_viewer

mkdir -p /engines/var/run/flags/

/usr/sbin/apache2ctl  -DFOREGROUND &

touch /engines/var/run/flags/startup_complete  
wait 
rm -f /engines/var/run/flags/startup_complete


 
 


#!/bin/sh

PID_FILE=/var/run/apache.pid

export PID_FILE
. /home/trap.sh
mkdir -p /var/log/log_viewer

mkdir -p /engines/var/run/flags/

/usr/sbin/apache2ctl  -DFOREGROUND &

touch /engines/var/run/flags/startup_complete  
wait 
rm -f /engines/var/run/flags/startup_complete


 
 


#!/bin/sh

PID_FILE=/run/apache2/apache2.pid

export PID_FILE
. /home/trap.sh

mkdir -p /engines/var/run/flags/
mkdir -p /var/log/apache2/

/usr/sbin/apache2ctl  -DFOREGROUND & 
touch /engines/var/run/flags/startup_complete  
wait 
rm -f /engines/var/run/flags/startup_complete


 
 


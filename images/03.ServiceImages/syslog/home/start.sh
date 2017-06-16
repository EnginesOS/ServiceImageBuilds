#!/bin/sh

PID_FILE=/var/run/ng-syslog.pid
export PID_FILE
. /home/engines/functions/trap.sh
mkdir -p /engines/var/run/flags/
 
sudo -n  syslog-ng -F -f /etc/syslog-ng/syslog-ng.conf -p /$PID_FILE --no-caps  -v -e &
touch  /engines/var/run/flags/startup_complete
wait  
exit_code=$?
rm /engines/var/run/flags/startup_complete
exit $exit_code





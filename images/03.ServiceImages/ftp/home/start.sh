#!/bin/sh

sudo /home/engines/scripts/_start_syslog.sh

PID_FILE=/var/run/ftpd.pid
export PID_FILE
. /home/engines/functions/trap.sh

mkdir -p /engines/var/run/flags

sudo -n  /usr/sbin/proftpd -n &
touch  /engines/var/run/flags/startup_complete
wait 
exit_code=$?
sudo -n /home/engines/scripts/_kill_syslog.sh

rm /engines/var/run/flags/startup_complete
exit $exit_code
#!/bin/sh


mkdir /var/log/proftpd
PID_FILE=/var/run/ftpd.pid
export PID_FILE
. /home/engines/functions/trap.sh

mkdir -p /home/engines/run/flags

sudo -n  /usr/sbin/proftpd -n &
touch  /home/engines/run/flags/startup_complete
wait 
exit_code=$?


rm /home/engines/run/flags/startup_complete
exit $exit_code
#!/bin/sh

PID_FILES="/var/run/slapd.pid /var/run/saslauthd.pid"
export PID_FILE
KILL_SCRIPT=/home/engines/scripts/signal/signal.sh

. /home/engines/functions/trap.sh

service_first_run_check


sudo -n /home/engines/scripts/startup/_start_slapd.sh &

startup_complete

wait
exit_code=$?

while test -f /home/engines/run/flags/backup
 do
  sleep 10
  exit_code=255
 done
 

shutdown_complete
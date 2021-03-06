#!/bin/sh

PID_FILES="/home/engines/run/slapd.pid /home/engines/run/saslauthd.pid"
export PID_FILE
KILL_SCRIPT=/home/engines/scripts/signal/signal.sh

. /home/engines/functions/trap.sh

service_first_run_check

while ! test -f /home/engines/run/flags/sig_term -o -f /home/engines/run/flags/sig_quit
 do
   sudo -n /home/engines/scripts/startup/sudo/_start.sh &

   startup_complete

  wait
  exit_code=$?

   while test -f /home/engines/run/flags/backup
    do
     sleep 10
      exit_code=1
   done
done
 
 /home/engines/scripts/signal/signal.sh

shutdown_complete
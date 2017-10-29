#!/bin/sh

PID_FILE=/var/run/dovecot/master.pid
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/stop_dovecot.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

service_first_run_check

sudo -n /usr/sbin/dovecot -F &
touch  /home/engines/run/flags/startup_complete
wait
#sleep 500
exit_code=$?

rm /home/engines/run/flags/startup_complete
exit $exit_code
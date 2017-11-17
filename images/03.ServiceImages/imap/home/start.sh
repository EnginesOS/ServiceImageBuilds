#!/bin/sh

PID_FILE=/var/run/dovecot/master.pid
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/stop_dovecot.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

service_first_run_check

sudo -n /usr/sbin/dovecot -F &

startup_complete

wait
exit_code=$?

shutdown_complete
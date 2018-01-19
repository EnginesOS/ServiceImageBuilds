#!/bin/sh

PID_FILE=/tmp/sleep.pid
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/kill_sleep.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

service_first_run_check

/home/engines/scripts/startup/init_dbs.sh
sudo -n /home/engines/scripts/startup/_start_postfix.sh &

wait
/home/engines/scripts/signal/kill_sleep.sh
/home/engines/scripts/signal/kill_postfix.sh




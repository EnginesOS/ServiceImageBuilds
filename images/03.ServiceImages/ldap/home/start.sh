#!/bin/sh

PID_FILE=/tmp/pids
export PID_FILE
KILL_SCRIPT=/home/engines/scripts/signal/signal.sh

. /home/engines/functions/trap.sh

service_first_run_check


sudo -n /home/engines/scripts/startup/_start_slapd.sh


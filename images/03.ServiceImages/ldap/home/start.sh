#!/bin/sh

PID_FILE=/tmp/pids
export PID_FILE
. /home/engines/functions/trap.sh

service_first_run_check


sudo -n /home/engines/scripts/startup/_start_slapd.sh


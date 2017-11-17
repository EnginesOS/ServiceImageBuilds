#!/bin/sh

PID_FILE=/tmp/ipsec.pid
export PID_FILE
KILL_SCRIPT=/home/engines/scripts/signal/shutdown.sh

export KILL_SCRIPT
. /home/engines/functions/trap.sh

service_first_run_check


sudo -n /home/engines/scripts/startup/_start.sh 




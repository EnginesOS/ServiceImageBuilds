#!/bin/sh


. /home/engines/functions/system_functions.sh
service_first_run_check

PID_FILE=/var/run/krb5kdc.pid 
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/kill_kerberos.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

sudo -n /home/engines/scripts/startup/_start.sh &
wait

/home/engines/scripts/signal/kill_kerberos.sh

shutdown_complete
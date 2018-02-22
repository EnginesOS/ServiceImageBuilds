#!/bin/sh
PID_FILES=".pidkrb5kdc.pid .pidkrb5admin.pid"

PID_FILE=/home/engines/run/krb5kdc.pid 
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/kill_kerberos.sh
export KILL_SCRIPT


. /home/engines/functions/trap.sh

service_first_run_check

sudo -n /home/engines/scripts/startup/_start.sh &
wait


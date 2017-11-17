#!/bin/sh
PID_FILES="/var/run/krb5kdc.pid /var/run/krb5admin.pid"

PID_FILE=/var/run/krb5kdc.pid 
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/kill_kerberos.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh
service_first_run_check

sudo -n /home/engines/scripts/startup/_start.sh &
wait


shutdown_complete
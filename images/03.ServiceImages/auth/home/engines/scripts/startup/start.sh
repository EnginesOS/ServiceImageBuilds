#!/bin/sh
PID_FILES="/home/engines/run/pidkrb5kdc.pid /home/engines/run/pidkrb5admin.pid"

PID_FILE=/home/engines/run/krb5kdc.pid 
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/kill_kerberos.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

sudo -n /home/engines/scripts/startup/sudo/_start.sh &

wait


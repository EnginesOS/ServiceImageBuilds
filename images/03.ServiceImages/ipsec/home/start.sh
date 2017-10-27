#!/bin/sh

PID_FILE=/tmp/ipsec.pid
export PID_FILE
KILL_SCRIPT=/home/engines/scripts/signal/shutdown.sh

export KILL_SCRIPT
. /home/engines/functions/trap.sh

service_first_run_check

#if ! test -f /etc/ipsec.d/private/ipvpn.key
# then
#	sudo -n /home/engines/scripts/first_run/_setup.sh
#fi

sudo -n /home/engines/scripts/startup/_start.sh 




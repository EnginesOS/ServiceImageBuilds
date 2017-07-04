#!/bin/sh

PID_FILE=/tmp/ipsec.pid
export PID_FILE
KILL_SCRIPT=/home/shutdown.sh

export KILL_SCRIPT
. /home/engines/functions/trap.sh


if ! test -f /etc/ipsec.d/private/ipvpn.key
 then
	sudo -n /home/setup.sh
fi

sudo -n /home/engines/scripts/_start_syslog.sh

touch /engines/var/run/flags/startup_complete  

sudo -n /home/_start.sh 
exit_code=$?

sudo -n  /home/engines/scripts/_kill_syslog.sh
rm -f /engines/var/run/flags/startup_complete
exit $exit_code

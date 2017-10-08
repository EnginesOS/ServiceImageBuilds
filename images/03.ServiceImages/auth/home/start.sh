#!/bin/sh

PID_FILE=/var/run/krb5kdc.pid 
export PID_FILE
. /home/engines/functions/trap.sh

mkdir -p /home/auth/logs/ 

if test -f /engines/var/run/flags/first_run.done
  then
  SIGNAL=0
	sudo -n /home/engines/scripts/_start_syslog.sh
	sudo -n /home/_start_kerobos.sh 
	sudo /home/engines/scripts/_kill_syslog.sh
	sleep 500
	exit $exit_code
  else
	/home/first_run.sh			
 fi

SIGNAL=0
sudo -n /home/engines/scripts/_start_syslog.sh

sudo -n /home/_start_kerobos.sh 
sudo /home/engines/scripts/_kill_syslog.sh
sleep 500
exit $exit_code
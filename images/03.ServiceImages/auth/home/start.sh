#!/bin/sh

PID_FILE=/var/run/krb5kdc.pid 
export PID_FILE
KILL_SCRIPT=/home/engines/scripts/signal/kill_kerberos.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

mkdir -p /home/auth/logs/ 

if test -f /engines/var/run/flags/first_run.done
  then
	sudo -n /home/engines/scripts/startup/_start.sh 	
  else
	/home/engines/scripts/first_run/first_run.sh			
 fi
 
#sleep 500
exit $exit_code
#!/bin/sh

PID_FILE=/var/run/krb5kdc.pid 
export PID_FILE
KILL_SCRIPT=/home/kill_kerberos.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

mkdir -p /home/auth/logs/ 

if test -f /engines/var/run/flags/first_run.done
  then
	sudo -n /home/_start.sh 	
  else
	/home/first_run.sh			
 fi
 
#sleep 500
exit $exit_code
#!/bin/sh

PID_FILE=/var/run/krb5kdc.pid 
export PID_FILE
KILL_SCRIPT=/home/engines/scripts/signal/kill_kerberos.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh
service_first_run_check

#mkdir -p /home/auth/logs/ 

#if test -f /home/engines/run/flags/first_run.done
#  then
#	sudo -n /home/engines/scripts/startup/_start.sh 	
#  else
#	/home/engines/scripts/first_run/first_run.sh			
# fi
#

sudo -n /home/engines/scripts/startup/_start.sh 	

exit $exit_code
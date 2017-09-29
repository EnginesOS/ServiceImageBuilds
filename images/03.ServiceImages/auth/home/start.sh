#!/bin/sh

PID_FILE=/var/run/krb5kdc.pid 
export PID_FILE
. /home/engines/functions/trap.sh

mkdir -p /home/auth/logs/ 

if ! test -f /engines/var/run/flags/first_run.done
  then
	/home/first_run.sh		
	touch /engines/var/run/flags/first_run.done
 fi

SIGNAL=0
sudo -n /home/engines/scripts/_start_syslog.sh
#sudo -n /home/_start_sshd.sh
sudo -n /home/_start_kerobos.sh 
sleep 500
exit_code=$?
sudo /home/engines/scripts/_kill_syslog.sh
rm -f /engines/var/run/flags/startup_complete

exit $exit_code
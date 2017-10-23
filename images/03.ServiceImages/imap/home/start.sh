#!/bin/sh

PID_FILE=/var/run/dovecot/master.pid
export PID_FILE
. /home/engines/functions/trap.sh

mkdir -p /engines/var/run/flags

if ! test -f /engines/var/run/flags/first_run_ran 
 then
  /home/engines/scripts/first_run/first_run.sh
  if test $? -eq 0
   then 
     touch /engines/var/run/flags/first_run_ran 
  fi   
 fi

sudo -n /home/engines/scripts/_start_syslog.sh

sudo -n /usr/sbin/dovecot -F &
touch  /engines/var/run/flags/startup_complete
wait
#sleep 500
exit_code=$?
sudo -n /home/engines/scripts/_kill_syslog.sh
rm /engines/var/run/flags/startup_complete
exit $exit_code
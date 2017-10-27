#!/bin/sh

PID_FILE=/var/run/dovecot/master.pid
export PID_FILE
. /home/engines/functions/trap.sh

mkdir -p /home/engines/run/flags

if ! test -f /home/engines/run/flags/first_run_ran 
 then
  /home/engines/scripts/first_run/first_run.sh
  if test $? -eq 0
   then 
     touch /home/engines/run/flags/first_run_ran 
  fi   
 fi

sudo -n /usr/sbin/dovecot -F &
touch  /home/engines/run/flags/startup_complete
wait
#sleep 500
exit_code=$?

rm /home/engines/run/flags/startup_complete
exit $exit_code
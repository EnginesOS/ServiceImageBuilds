#!/bin/sh

if ! test -f /engines/var/run/flags/first_run
  then

  	touch /engines/var/run/flags/first_run
  fi


export PID_FILE
. /home/trap.sh

mkdir -p /engines/var/run/flags/

sudo -n /home/engines/scripts/_start_syslog.sh

echo started syslog


touch  /engines/var/run/flags/startup_complete

sleep 3600

rm /engines/var/run/flags/startup_complete  
sudo -n /home/engines/scripts/_kill_syslog.sh


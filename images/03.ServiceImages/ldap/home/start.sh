#!/bin/sh

if ! test -f /engines/var/run/flags/first_run
  then
  	touch /engines/var/run/flags/first_run
  fi

PID_FILE=/tmp/pids
export PID_FILE
. /home/engines/functions/trap.sh


sudo -n /home/engines/scripts/_start_syslog.sh

echo started syslog

sudo -n /home/_start_slapd.sh

sudo -n /usr/sbin/apache2ctl start 
echo -n " " >> /tmp/pids
cat  /run//apache2/apache2.pid >> /tmp/pids
touch  /engines/var/run/flags/startup_complete
wait
exit_code=$?

rm /engines/var/run/flags/startup_complete  
sudo -n /home/engines/scripts/_kill_syslog.sh
exit $exit_code


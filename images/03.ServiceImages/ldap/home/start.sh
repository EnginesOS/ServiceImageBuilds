#!/bin/sh

if ! test -f /engines/var/run/flags/first_run
  then
  	touch /engines/var/run/flags/first_run
  fi

PID_FILE=/tmp/pids
export PID_FILE
. /home/trap.sh

mkdir -p /engines/var/run/flags/

sudo -n /home/engines/scripts/_start_syslog.sh

echo started syslog
sudo -n /usr/sbin/slapd -d 4
echo -n $% > /tmp/pids
sudo -n /usr/sbin/apache2ctl  -DFOREGROUND & 
echo -n " " >> /tmp/pids
cat  /run//apache2/apache2.pid >> /tmp/pids
wait

touch  /engines/var/run/flags/startup_complete

sleep 360

rm /engines/var/run/flags/startup_complete  
sudo -n /home/engines/scripts/_kill_syslog.sh


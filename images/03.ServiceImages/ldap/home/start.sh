#!/bin/sh

if ! test -f /engines/var/run/flags/first_run
  then
  /home/configure_kerobos.sh
  	touch /engines/var/run/flags/first_run
  fi
if ! test -d /var/log/apache2/
 then 
 mkdir -p /var/log/apache2/
fi

PID_FILE=/tmp/pids
export PID_FILE
. /home/engines/functions/trap.sh


sudo -n /home/engines/scripts/_start_syslog.sh

echo started syslog



sudo -n /usr/sbin/apache2ctl start 
echo -n " " >> /tmp/pids
cat  /run//apache2/apache2.pid > /tmp/pids

sudo -n /home/_start_slapd.sh

exit_code=$?

sleep 300

sudo -n /home/engines/scripts/_kill_syslog.sh
exit $exit_code


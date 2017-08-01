#!/bin/sh

touch /engines/var/run/flags/kerobos_configured

if ! test -f /engines/var/run/flags/first_run
  then
    sudo -n /home/_first_run.sh
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


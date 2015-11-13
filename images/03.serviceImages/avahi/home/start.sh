#!/bin/sh



PID_FILE=/var/run/avahi.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/


sudo -n syslogd  -R syslog.engines.internal:5140
sudo -n /usr/sbin/avahi-daemon & 
echo $% >$PID_FILE
/home/publish_aliases.sh
touch /engines/var/run/flags/startup_complete
wait  ` cat $PID_FILE`

rm /engines/var/run/flags/startup_complete

#!/bin/sh



PID_FILE=/var/run/dhcpd.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/




sudo -n syslogd  -R syslog.engines.internal:5140
sudo -n /usr/sbin/dhcpd  -cf /etc/dhcpd/dhcpd.conf -pf /var/run/dhcpd.pid  -f & 
touch /engines/var/run/flags/startup_complete
wait  

rm /engines/var/run/flags/startup_complete

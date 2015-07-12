#!/bin/sh


PID_FILE=/var/spool/postfix/pid/master.pid

export PID_FILE
. /home/trap.sh

mkdir -p /engines/var/run/flags/

sudo /sbin/syslogd -R syslog.engines.internal:5140
if test -f /etc/postfix/transport 
	then
		sudo postmap /etc/postfix/transport
	fi 
sudo /usr/lib/postfix/master &
touch  /engines/var/run/flags/startup_complete
wait
rm /engines/var/run/flags/startup_complete  
sudo /home/engines/scripts/_kill_syslog.sh


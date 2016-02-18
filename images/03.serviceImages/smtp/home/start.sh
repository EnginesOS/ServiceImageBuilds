#!/bin/sh


PID_FILE=/var/spool/postfix/pid/master.pid

export PID_FILE
. /home/trap.sh

mkdir -p /engines/var/run/flags/

sudo /sbin/syslogd -R syslog.engines.internal:514
if ! test -f /etc/postfix/transport 
	then
	 echo "	*	smtp:" >/etc/postfix/transport
	fi 
if ! test -f /etc/postfix/mailname
	then
		echo "not.set" > /etc/postfix/mailname
	fi
		
sudo postmap /etc/postfix/transport

sudo /usr/lib/postfix/master &
touch  /engines/var/run/flags/startup_complete
wait
rm /engines/var/run/flags/startup_complete  
sudo /home/engines/scripts/_kill_syslog.sh


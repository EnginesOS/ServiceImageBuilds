#!/bin/sh


PID_FILE=/var/spool/postfix/pid/master.pid

export PID_FILE
. /home/trap.sh

mkdir -p /engines/var/run/flags/

sudo -n /home/engines/scripts/_start_syslog.sh

if ! test -f /etc/postfix/transport 
	then
	 echo "	*	smtp:" >/etc/postfix/transport
	fi 
if ! test -f /etc/postfix/mailname
	then
		echo "not.set" > /etc/postfix/mailname
	fi
		
sudo -n postmap /etc/postfix/transport

sudo -n /usr/lib/postfix/sbin/master &
touch  /engines/var/run/flags/startup_complete
wait
rm /engines/var/run/flags/startup_complete  
sudo -n /home/engines/scripts/_kill_syslog.sh


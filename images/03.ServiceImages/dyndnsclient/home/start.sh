#!/bin/bash

PID_FILE=/home/dyndns/dyndns.pid
export PID_FILE
. /home/engines/functions/trap.sh

touch /tmp/start_dyndns

mkdir -p /engines/var/run/flags

if ! test -f /home/dyndns/dyndns.conf
then 
	touch /engines/var/run/flags/not_configured
	sleep 20  #wait for system apply pending configuration
	exit
else
   rm -f /engines/var/run/flags/not_configured
fi

sudo /home/engines/scripts/_start_syslog.sh


mkdir -p /engines/var/run/flags/

	ddclient  -daemon 300 -syslog -foreground -file /home/dyndns/dyndns.conf -cache /home/dyndns/cache   -pid /home/dyndns/dyndns.pid &
	if ! test -f /home/dyndns/dyndns.pid
	then
	  touch /engines/var/run/flags/startup_failed
	 else
	   rm -r /engines/var/run/flags/startup_failed
	fi
	touch /engines/var/run/flags/startup_complete
	wait 
	
	rm /engines/var/run/flags/startup_complete
	sudo -n /home/engines/scripts/_kill_syslog.sh


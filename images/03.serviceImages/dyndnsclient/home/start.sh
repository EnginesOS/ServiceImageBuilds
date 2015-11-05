#!/bin/bash

PID_FILE=/home/dyndns/dyndns.pid
export PID_FILE
. /home/trap.sh

touch /tmp/start_dyndns

while test -f /tmp/start_dyndns
do
rm /tmp/start_dyndns
while ! test -f /home/dyndns/dyndns.conf
do 
	sleep 30
done

sudo syslogd  -R syslog.engines.internal:5140

mkdir -p /engines/var/run/flags/

	ddclient  -daemon 300 -syslog -foreground -file /home/dyndns/dyndns.conf -cache /home/dyndns/cache   -pid /home/dyndns/dyndns.pid &
	if ! test -f /home/dyndns/dyndns.pid
	then
	  /tmp/start_dyndns
          rm /home/dyndns/dyndns.conf
	fi
	touch /engines/var/run/flags/startup_complete
	wait 
	
	rm /engines/var/run/flags/startup_complete
	sudo /home/engines/scripts/_kill_syslog.sh
done

#!/bin/bash

PID_FILE=/home/dyndns/dyndns.pid
export PID_FILE
. /home/engines/functions/trap.sh

touch /tmp/start_dyndns

startup_complete

if ! test -f /home/dyndns/dyndns.conf
then 
	touch /home/engines/run/flags/not_configured
	sleep 20  #wait for system apply pending configuration
	exit
else
   rm -f /home/engines/run/flags/not_configured
fi

ddclient  -daemon 300 -syslog -foreground -file /home/dyndns/dyndns.conf -cache /home/dyndns/cache   -pid /home/dyndns/dyndns.pid &



wait 
exit_code=$?
	
shutdown_complete


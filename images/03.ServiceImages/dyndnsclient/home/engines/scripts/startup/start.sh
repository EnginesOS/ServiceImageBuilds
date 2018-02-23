#!/bin/bash

PID_FILE=/home/engines/run/dyndns.pid
export PID_FILE
. /home/engines/functions/trap.sh

touch /tmp/start_dyndns

startup_complete

if ! test -f /home/dyndns/dyndns.conf
then 
touch /home/engines/run/flags/not_configured
	sleep 20  #wait for system apply pending configuration
      if ! test -f /home/dyndns/dyndns.conf
       then 	 
	    exit
      fi
   rm -f /home/engines/run/flags/not_configured
fi

ddclient  -daemon 300 -syslog -foreground -file /home/dyndns/dyndns.conf -cache /home/dyndns/cache   -pid $PID_FILE &

wait 
exit_code=$?
	
shutdown_complete


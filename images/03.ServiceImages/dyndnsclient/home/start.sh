#!/bin/bash

PID_FILE=/home/dyndns/dyndns.pid
export PID_FILE
. /home/engines/functions/trap.sh

touch /tmp/start_dyndns

mkdir -p /home/engines/run/flags

if ! test -f /home/dyndns/dyndns.conf
then 
	touch /home/engines/run/flags/not_configured
	sleep 20  #wait for system apply pending configuration
	exit
else
   rm -f /home/engines/run/flags/not_configured
fi


ddclient  -daemon 300 -syslog -foreground -file /home/dyndns/dyndns.conf -cache /home/dyndns/cache   -pid /home/dyndns/dyndns.pid &

if ! test -f /home/dyndns/dyndns.pid
 then
  touch /home/engines/run/flags/startup_failed
else
  rm -r /home/engines/run/flags/startup_failed
fi

touch /home/engines/run/flags/startup_complete
wait 
exit_code=$?
	
rm /home/engines/run/flags/startup_complete


exit $exit_code

#!/bin/sh

if test -f /var/run/rsyslogd.pid  
	then
		pid=`cat /var/run/rsyslogd.pid`
		kill -TERM  $pid 
		 echo kill -TERM  $pid syslog >>  /home/engines/run/flags/signals 
		kill -0 $pid &>/dev/null
 	  while test $? -eq 0
        do             
	      sleep 1 # cant wait on pid as not a child of this shell
	      echo wait on syslog $pid >>  /home/engines/run/flags/signals 
	      kill -0 $pid &>/dev/null
	  done 	
	  
	rm /var/run/rsyslogd.pid  
fi
	

	
	
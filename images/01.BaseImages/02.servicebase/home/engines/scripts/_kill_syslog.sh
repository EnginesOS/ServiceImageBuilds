#!/bin/sh

if test -f /var/run/rsyslogd.pid  
	then
		pid=`cat  /var/run/rsyslogd.pid  `
		kill -TERM  $pid
		kill -0 $pid
 	  while test $? -eq 0
        do             
	      sleep 1 # cant wait on pid as not a child of this shell
	      kill -0 $pid &>/dev/null
	  done 	
fi
	

	
	
#!/bin/sh

if test -f /var/run/rsyslogd.pid  
	then
		pid=`cat  /var/run/rsyslogd.pid  `
		kill -TERM  $pid
if test -f /var/run/rsyslogd.pid  
 then			
	pid=`cat /var/run/rsyslogd.pid  `
	echo $pid |grep ^[0-9]
 	
	if test $? -ne 0
        then
                echo no wait for syslog
        else
	              sleep 1 # cant wait on pid as not a child of this shell
	fi
  fi							
fi
	

	
	
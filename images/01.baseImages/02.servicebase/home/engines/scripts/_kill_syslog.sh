#!/bin/sh

if test -f /run/syslogd.pid 
	then
		pid=`cat  /run/syslogd.pid `
		kill -TERM  $pid
			
	pid=`cat  /run/syslogd.pid `
	echo $pid |grep ^[0-9]
 	
	if test $? -ne 0
        then
                echo no wait for syslog
        else
                echo wait \"$pid\"
                wait $pid   
	fi							
fi
	

	
	
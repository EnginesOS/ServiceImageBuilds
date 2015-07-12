#!/bin/sh

echo received $1
SIGNAL=$1
PID_FILE=$2

kill -$SIGNAL `cat $PID_FILE`
	
 if test -f $PID_FILE
 	then
 	pid=`cat $PID_FILE`
 	
 	echo $pid |grep ^[0-9]
 	
	if test $? -ne 0
        then
                echo no wait \"$pid\"
        else
                echo wait \"$pid\"
                wait $pid   
	fi
 	

	fi
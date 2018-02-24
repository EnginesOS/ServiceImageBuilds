#!/bin/sh

echo received $1
SIGNAL=$1
PID_FILE=$2

kill -$SIGNAL `cat $PID_FILE`
 
if test -f /home/engines/run/rpc.pid
	then
		kill -$SIGNAL `cat /home/engines/run/rpcbind.pid`
	fi
	
 if test -f $PID_FILE
 	then
 	pid=`cat $PID_FILE`
 							case $pid in
						 (*[^0-9]*|'') t=1;;
   						 (*)    wait $pid ;;  
					esac
	fi
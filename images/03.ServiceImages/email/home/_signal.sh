#!/bin/sh

echo received $1
SIGNAL=$1
PID_FILE=$2
kill -$SIGNAL `cat /var/run/apache2/apache2.pid`
kill -$SIGNAL `cat /var/run/engines/grey.pid`
kill -$SIGNAL `cat $PID_FILE`
	
 if test -f $PID_FILE
 	then
 	pid=`cat $PID_FILE`
 	  case $pid in
		(*[^0-9]*|'') t=1;;
   	    (*)    wait $pid ;;  
	  esac
fi
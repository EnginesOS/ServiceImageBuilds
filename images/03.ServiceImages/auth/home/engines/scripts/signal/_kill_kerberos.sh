#!/bin/bash

kill -$SIGNAL `cat $PID_FILE`
if ! test $SIGNAL = HUP
 then
	/home/engines/scripts/_kill_syslog.sh
fi

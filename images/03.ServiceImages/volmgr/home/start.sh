#!/bin/sh

PID_FILE=/var/run/pid
export PID_FILE
. /home/engines/functions/trap.sh

startup_complete

c=1
while test $c -ne 0
do
sleep 3600 &
echo $! > /var/run/pid
wait

 if test -f /home/engines/run/sig_term
  then
  	c=0
  fi
done

shutdown_complete


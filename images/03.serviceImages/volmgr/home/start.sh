#!/bin/sh

PID_FILE=/var/run/pid
export PID_FILE
. /home/trap.sh
echo $$ > /var/run/pid
mkdir -p /engines/var/run/flags/
 

touch  /engines/var/run/flags/startup_complete
c=1
while test $c -ne 0
do
wait
 if test $SIGNAL -ne 1
  then
  	c=0
  fi
done

rm /engines/var/run/flags/startup_complete
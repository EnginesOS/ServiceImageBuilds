#!/bin/sh


PID_FILE=/var/run/mongodb.pid
export PID_FILE
. /home/trap.sh

 mkdir -p /var/log/mongodb/
 
mkdir -p /engines/var/run/flags/


 mongod   -v  -f /etc/mongod.conf  --directoryperdb    --journal &
touch  /engines/var/run/flags/startup_complete
wait  

rm /engines/var/run/flags/startup_complete
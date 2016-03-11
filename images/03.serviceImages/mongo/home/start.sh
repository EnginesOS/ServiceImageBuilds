#!/bin/sh


PID_FILE=/var/run/engines/mongodb.pid
export PID_FILE
. /home/trap.sh

 mkdir -p /var/log/mongodb/
 
mkdir -p /engines/var/run/flags/


 mongod   -v  -f /etc/mongod.conf  --directoryperdb  --dbpath /data/db/  --journal &
pid=$!

echo $echo >/var/run/engines/mongodb.pid

touch  /engines/var/run/flags/startup_complete
wait  

rm /engines/var/run/flags/startup_complete
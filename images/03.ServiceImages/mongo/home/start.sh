#!/bin/sh


PID_FILE=/var/run/engines/mongodb.pid
export PID_FILE
. /home/engines/functions/trap.sh

 mkdir -p /var/log/mongodb/
 
mkdir -p /engines/var/run/flags/


 mongod   -v  -f /etc/mongod.conf  --directoryperdb  --dbpath /data/db/  --journal &
pid=$!

echo -n $pid >/var/run/engines/mongodb.pid
if ! test -d /data/db/.priv
 then
 sleep 30
  mkdir -p /data/db/.priv
 	/home/firstrun.sh
 fi

touch  /engines/var/run/flags/startup_complete
wait  
exit_code=$?

rm /engines/var/run/flags/startup_complete
exit $exit_code
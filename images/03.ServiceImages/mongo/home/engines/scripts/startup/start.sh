#!/bin/sh


PID_FILE=/home/engines/run/mongodb.pid
export PID_FILE
. /home/engines/functions/trap.sh


mkdir -p /var/log/mongodb/

service_first_run_check

 
mongod -v  -f /etc/mongod.conf  --directoryperdb  --dbpath /data/db/  --journal &
pid=$!

echo -n $pid >//home/engines/run/mongodb.pid
if ! test -d /data/db/.priv
 then
 sleep 30
  mkdir -p /data/db/.priv
 	/home/firstrun.sh
fi

startup_complete

wait  
exit_code=$?

shutdown_complete

#!/bin/sh



PID_FILE=/var/run/redis-server.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/

if test -f /engines/var/run/flags/restart_required
 then
  rm -f /engines/var/run/flags/restart_required
fi


touch /engines/var/run/flags/startup_complete
redis &

wait 



rm /engines/var/run/flags/startup_complete

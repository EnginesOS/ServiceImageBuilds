#!/bin/sh


PID_FILE=/tmp/pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/

cd /home/registry
/usr/local/rbenv/shims/ruby server.rb &
pid=$!
echo $pid >/tmp/pid

touch /engines/var/run/flags/startup_complete  
wait 

rm -f /engines/var/run/flags/startup_complete

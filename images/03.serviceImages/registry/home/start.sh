#!/bin/sh


PID_FILE=/tmp/pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/

cd /home/registry
cd /home/registry/EnginesSystemRegistry/src/
git pull
/usr/local/rbenv/shims/ruby /home/registry/EnginesSystemRegistry/src/server.rb &
pid=$!
echo $pid >/tmp/pid

touch /engines/var/run/flags/startup_complete  
wait 
kill -TERM  $pid
rm -f /engines/var/run/flags/startup_complete

#!/bin/sh

export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1

pid=$$
echo $pid >/tmp/pid
PID_FILE=/engines/var/run/registry.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/

cd /home/registry
cd /home/registry/EnginesSystemRegistry/src/
git pull
cd ..
 rm -f /tmp/registry.lock

thin -C config.yaml -R config.ru start --threaded> /var/log/regsitry.log&


touch /engines/var/run/flags/startup_complete  
wait 
kill -TERM  $pid
rm -f /engines/var/run/flags/startup_complete


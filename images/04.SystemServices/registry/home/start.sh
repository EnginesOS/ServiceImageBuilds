#!/bin/sh

export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1

pid=$$
echo $pid >/tmp/pid
PID_FILE=/engines/var/run/registry.pid
export PID_FILE
. /home/engines/functions/trap.sh


mkdir -p /engines/var/run/flags/

cd /home/registry
cd /home/registry/EnginesSystemRegistry/src/
git pull
cd ..
 rm -f /tmp/registry.lock

thin -C config.yaml -R config.ru start > /var/log/regsitry.log&

#--threaded

touch /engines/var/run/flags/startup_complete  
wait 
exit_code=$?

rm -f /engines/var/run/flags/startup_complete
exit $exit_code




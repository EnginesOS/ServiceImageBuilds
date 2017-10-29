#!/bin/sh

export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1


PID_FILE=/home/engines/run/registry.pid
export PID_FILE
. /home/engines/functions/trap.sh

cd /home/registry
cd /home/registry/EnginesSystemRegistry/src/
git pull
cd ..
 rm -f /tmp/registry.lock
chmod og-rwx /opt/engines/run/service_manager/services.yaml*
thin -C config.yaml -R config.ru start > /var/log/regsitry.log&
pid=$!
echo $pid >/tmp/pid
#--threaded

touch /home/engines/run/flags/startup_complete  
wait 
exit_code=$?

rm -f /home/engines/run/flags/startup_complete
exit $exit_code




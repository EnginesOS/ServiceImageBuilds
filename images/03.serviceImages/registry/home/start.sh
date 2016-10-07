#!/bin/sh
export RUBY_GC_HEAP_INIT_SLOTS=1000000 # 1M
export RUBY_GC_HEAP_FREE_SLOTS=500000  # 0.5M
export RUBY_GC_HEAP_GROWTH_FACTOR=1.1
export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=10000000 # 10M
export RUBY_GC_MALLOC_LIMIT_MAX=100000000    # 100M
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
#/usr/local/rbenv/shims/ruby /home/registry/EnginesSystemRegistry/src/server.rb  > /var/log/regsitry.log&
/usr/local/rbenv/shims/thin  -C config.yaml -R config.ru start > /var/log/regsitry.log&


touch /engines/var/run/flags/startup_complete  
wait 
kill -TERM  $pid
rm -f /engines/var/run/flags/startup_complete


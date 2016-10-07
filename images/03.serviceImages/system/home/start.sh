#!/bin/sh
export RUBY_GC_HEAP_INIT_SLOTS=1000000 # 1M
export RUBY_GC_HEAP_FREE_SLOTS=500000  # 0.5M
export RUBY_GC_HEAP_GROWTH_FACTOR=1.1
export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=10000000 # 10M
export RUBY_GC_MALLOC_LIMIT_MAX=100000000    # 130M
export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1

/home/clear_flags.sh
control_ip=`netstat -rn |grep ^0.0.0 | awk '{print $2}'`
echo $control_ip > /engines/var/run/control_ip
export control_ip 
PID_FILE=/engines/var/run/system.pid
export PID_FILE
. /home/trap.sh

if ! test -d  /engines/var/run/flags/
 then
	mkdir -p /engines/var/run/flags/
 fi

cd /home
/usr/local/rbenv/versions/2.3.0/bin/thin    -C config.yaml -R ./config.ru start > /var/log/system.log &


touch /engines/var/run/flags/startup_complete  
wait 
rm -f /engines/var/run/flags/startup_complete


#!/bin/sh

PID_FILE=/home/engines/run/control.pid
export PID_FILE
. /home/engines/functions/trap.sh

/home/engines/scripts/engine/deploy.sh

/usr/bin/memcachedb -H /home/app/cache -l /var/log/memcache.log &
memcache_pid=$!

cd /home/app/control

bundle exec thin --threaded\
	 --ssl --ssl-key-file /home/engines/etc/ssl//keys/control.key\
	  --ssl-cert-file /home/engines/etc/ssl//certs/control.crt\
	   -C /home/config.yaml \
	   -R /home/config.ru \
	   -l /var/log/control.log \
	   start &
echo -n $! $memcache_pid > /home/engines/run/control.pid 

startup_complete

wait 
exit_code=$?

shutdown_complete

#!/bin/sh

export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1

/home/engines/scripts/startup/clear_flags.sh
SYSTEM_IP=` cat /etc/hosts |grep system |cut -f1`

echo $SYSTEM_IP > /home/engines/run/control_ip
export SYSTEM_IP 
PID_FILE=/home/engines/run/system.pid
export PID_FILE
. /home/engines/functions/trap.sh

cd /home

 if test -f /home/engines/etc/ssl//keys/system.key 
  then
	thin --threaded --ssl --ssl-key-file /home/engines/etc/ssl//keys/system.key --ssl-cert-file /home/engines/etc/ssl/certs/system.crt -C /home/app/config.yaml -R /home/app/config.ru start > /var/log/system.log &
  else
	thin --threaded -C config.yaml -R ./config.ru start > /var/log/system.log &
 fi

sleep 500
#touch /home/engines/run/flags/startup_complete  done in code
wait 
exit_code=$?

shutdown_complete




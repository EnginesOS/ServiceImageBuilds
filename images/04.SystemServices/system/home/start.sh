#!/bin/sh

export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1

/home/clear_flags.sh
SYSTEM_IP=` cat /etc/hosts |grep system |cut -f1`
#control_ip=`netstat -rn |grep ^0.0.0 | awk '{print $2}' | tr -d '\n'`
echo $SYSTEM_IP > /engines/var/run/control_ip
export SYSTEM_IP 
PID_FILE=/engines/var/run/system.pid
export PID_FILE
. /home/engines/functions/trap.sh

if ! test -d  /engines/var/run/flags/
 then
	mkdir -p /engines/var/run/flags/
 fi

cd /home
 if test -f /opt/engines/etc/ssl/keys/system/server.key 
  then
	thin --threaded --ssl --ssl-key-file /opt/engines/etc/ssl/keys/system/server.key --ssl-cert-file /opt/engines/etc/ssl/certs/system/server.crt -C config.yaml -R ./config.ru start > /var/log/system.log &
  else
	thin  --threaded -C config.yaml -R ./config.ru start > /var/log/system.log &
 fi
#--threaded  

#touch /engines/var/run/flags/startup_complete  
wait 
exit_code=$?
rm -f /engines/var/run/flags/startup_complete
exit $exit_code


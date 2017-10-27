#!/bin/sh

export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1

/home/engines/scripts/startup/clear_flags.sh
SYSTEM_IP=` cat /etc/hosts |grep system |cut -f1`

echo $SYSTEM_IP > /home/engines/run/control_ip
export SYSTEM_IP 
PID_FILE=/home/engines/run/system.pid
export PID_FILE
. /home/engines/functions/trap.sh

# was /opt/engines/etc/ssl/keys/ and /opt/engines/etc/ssl/certs/engines.crt
cd /home
 if test -f /engines/ssl/keys/engines.key 
  then
	thin --threaded --ssl --ssl-key-file /engines/ssl/keys/engines.key --ssl-cert-file /engines/ssl/certs/engines.crt -C config.yaml -R ./config.ru start > /var/log/system.log &
  else
	thin --threaded -C config.yaml -R ./config.ru start > /var/log/system.log &
 fi


#touch /home/engines/run/flags/startup_complete  done in code
wait 
exit_code=$?
rm -f /home/engines/run/flags/startup_complete
exit $exit_code


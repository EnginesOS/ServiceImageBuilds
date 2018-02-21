#!/bin/sh
echo "started" > /home/engines/run/flags/state

start_thin()
{
 if test -f /home/engines/etc/ssl/keys/system.key 
  then
	thin --threaded --ssl --ssl-key-file /home/engines/etc/ssl//keys/system.key --ssl-cert-file /home/engines/etc/ssl/certs/system.crt -C /home/app/config.yaml -R /home/app/config.ru start > /var/log/system.log &
  else
	thin --threaded -C /home/app/config.yaml -R /home/app/config.ru start > /var/log/system.log &
 fi
}

start_puma()
{  
if test -f /home/engines/etc/ssl/keys/system.key 
  then
    options="-C /home/app/puma.rb"
   else
      options="-C /home/app/puma_nocert.rb"
   fi   
puma $options &

}
export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1

/home/engines/scripts/startup/clear_flags.sh
SYSTEM_IP=` cat /etc/hosts |grep system |cut -f1`

echo $SYSTEM_IP > /home/engines/run/control_ip
export SYSTEM_IP 
PID_FILE=/home/engines/run/system.pid
export PID_FILE
. /home/engines/functions/trap.sh

cd /home
if test -f /home/engines/run/flags/puma
 then
  start_puma
 else 
  start_thin
fi  

#touch /home/engines/run/flags/startup_complete  done in code
wait 
exit_code=$?

shutdown_complete




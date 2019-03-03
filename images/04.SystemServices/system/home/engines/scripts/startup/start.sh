#!/bin/bash
echo "started" > /home/engines/run/flags/state

start_thin()
{
if test -z $THREADED
 then
  THREADED=' '
 else
    THREADED=--threaded
 fi   
 if test -f /home/engines/etc/ssl/keys/system.key 
  then
	thin $THREADED --ssl --ssl-key-file /home/engines/etc/ssl//keys/system.key --ssl-cert-file /home/engines/etc/ssl/certs/system.crt -C /home/app/config.yml -R /home/app/config.ru start >> /var/log/system.log &
  else
	thin $THREADED -C /home/app/config.yml -R /home/app/config.ru start > /var/log/system.log &
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

start_passenger()
{
#cp /home/ruby_env /home/.env_vars
#  for env_name in `cat /home/app.env `
#  	do
#   	  if ! test -z  "${!env_name}"
#        then
#  	      echo  "passenger_env_var $env_name \"${!env_name}\";" >> /home/.env_vars
#  	  fi
#  	done 

 nginx &
echo $! >  $PID_FILE
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
 elif test -f /home/engines/run/flags/passenger
  then
   start_passenger
 else 
  start_thin
fi  
echo $! > $PID_FILE

#touch /home/engines/run/flags/startup_complete  done in code
wait 
exit_code=$?
TS=`date`
echo System Shutdown $TS

shutdown_complete




#!/bin/bash
echo "started" > /home/engines/run/flags/state

ulimit
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
	thin $THREADED --ssl --ssl-key-file /home/engines/etc/ssl/keys/system.key --ssl-cert-file /home/engines/etc/ssl/certs/system.crt -C /home/app/config.yml -R /home/app/config.ru start >> /var/log/system.log &
	echo $! > $PID_FILE
  else
	thin $THREADED -C /home/app/config.yml -R /home/app/config.ru start > /var/log/system.log &
	echo $! > $PID_FILE
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
echo -n $! > $PID_FILE

}

start_rainbows()
{
cd /home/app

/home/engines/scripts/first_run/first_run.sh

if test -f /home/engines/etc/ssl/keys/system.key 
  then
     rainbows -p 8080 -o 127.0.0.1 -c /home/app/rainbows_haproxy.rb &
    #rainbows -c /home/app/rainbows_nginx.rb &
    sleep 2
    echo -n $! > $PID_FILE    
     haproxy -f /etc/haproxy/haproxy.cfg  &
     pid=$!
     if test $? -ne 0
      then
        sleep 3
        haproxy -f /etc/haproxy/haproxy.cfg  &
        pid=$!
     fi
    echo -n " $pid" > $PID_FILE
   # nginx -c /etc/nginx/nginx_rainbows_https.conf &
   else
     rainbows -p 2380 -o 0.0.0.0 -c /home/app/rainbows_first_run.rb &
    echo -n $! > $PID_FILE
   fi 

}

start_passenger()
{
if ! test -f /var/log/nginx 
 then
  mkdir -p /var/log/nginx
fi

if test -f /home/engines/etc/ssl/keys/system.key 
  then
    options="-c /etc/nginx/nginx_https.conf"
   else
      options="-c /etc/nginx/nginx_http.conf"
   fi   
cp /home/ruby_env /home/.env_vars
  for env_name in `cat /home/app.env `
  	do
   	  if ! test -z  "${!env_name}"
        then
  	      echo  "passenger_env_var $env_name \"${!env_name}\";" >> /home/.env_vars
  	  fi
  	done 

 nginx $options &
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

service_first_run_check

cd /home
if test -f /home/engines/run/flags/puma
 then
  start_puma
 elif test -f /home/engines/run/flags/passenger
  then
   echo "Using Passenger"
   start_passenger
 elif test -f /home/engines/run/flags/start_thin
  then
   echo "Using Thin"
   start_thin
 else 
   echo "Using Rainbows"
 start_rainbows  
fi  


#touch /home/engines/run/flags/startup_complete  done in code
wait 
exit_code=$?
TS=`date`
echo System Shutdown $TS

shutdown_complete

if test -f /home/engines/run/flags/wait_before_shutdown
 then 
  sleep 500
fi  


#!/bin/sh

PID_FILE=/home/engines/run/control.pid
export PID_FILE
. /home/engines/functions/trap.sh

if ! test -d /home/app/cert
 then
  mkdir -p /home/app/cert
  cat /home/engines/etc/ssl/certs/control.crt /home/engines/etc/ssl/keys/control.key > /home/app/cert/control_key.crt
  chmod og-rwx -R /home/app/cert
fi

/home/engines/scripts/engine/deploy.sh

/usr/bin/memcachedb -H /home/app/cache -l /var/log/memcache.log &
memcache_pid=$!


     
cd /home/app/control

cp /home/engines/config.yaml /home/app/control
cp /home/engines/config.ru /home/app/control
cp /home/engines/rainbows_haproxy.rb /home/app/control
 bundle exec rainbows  -p 8080 -o 127.0.0.1 -c rainbows_haproxy.rb &
rid=$!
 
      haproxy -f /etc/haproxy/haproxy.cfg  &
     hapid=$!
 

echo -n $rid $hapid $memcache_pid > $PID_FILE

sleep 400
startup_complete

wait 
exit_code=$?

shutdown_complete

#!/bin/sh

SYSTEM_IP=`netstat -rn |grep ^0.0.0 | awk '{print $2}' | tr -d '\n'`
echo $SYSTEM_IP > /home/engines/run/control_ip
export SYSTEM_IP 
PID_FILE=/home/engines/run/firstrun.pid
export PID_FILE
. /home/engines/functions/trap.sh

cd /home/app

subject="/C=AU/ST=NSW/L=Sydney/O=install/CN=installer"
openssl req \
       -newkey rsa:2048 -nodes -keyout first_run.key  -sub $subject \
       -x509 -days 365 -out first_run.crt
       
chmod og-r  first_run.key
      
       
/home/engines/scripts/engine/deployment.sh

bundle exec thin --ssl --ssl-key-file first_run.key --ssl-cert-file first_run.crt -R ./config.ru start > /var/log/firstrun.log &

startup_complete

wait 
exit_code=$?
kill -TERM  cat /home/engines/run/firstrun.pid`

shutdown_complete


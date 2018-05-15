#!/bin/sh

SYSTEM_IP=`netstat -rn |grep ^0.0.0 | awk '{print $2}' | tr -d '\n'`
echo $SYSTEM_IP > /home/engines/run/control_ip
export SYSTEM_IP 
PID_FILE=/home/engines/run/firstrun.pid
export PID_FILE
. /home/engines/functions/trap.sh

cd /home/app

if ! test -f ./first_run.key
 then
   subject="/C=AU/ST=NSW/L=Sydney/O=install/CN=installer"
   openssl req \
       -x509 -newkey rsa:2048 -nodes -keyout ./first_run.key -out  ./first_run.crt -subj $subject \
       -days 365
  chmod og-r  first_run.key     
fi        
        
/home/engines/scripts/engine/deployment.sh

bundle exec thin --ssl --ssl-key-file ./first_run.key --ssl-cert-file ./first_run.crt -R ./config.ru start > /var/log/firstrun.log &
echo $! >$PID_FILE
startup_complete

wait 
exit_code=$?
kill -TERM  `cat /home/engines/run/firstrun.pid`

shutdown_complete


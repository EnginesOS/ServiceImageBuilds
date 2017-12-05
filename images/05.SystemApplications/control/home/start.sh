#!/bin/sh

PID_FILE=/home/engines/run/control.pid
export PID_FILE
. /home/engines/functions/trap.sh

/home/engines/scripts/engine/deploy.sh

cd /home/app/control

bundle exec thin --threaded --ssl --ssl-key-file /home/engines/etc/ssl//keys/control.key --ssl-cert-file /home/engines/etc/ssl//certs/control.crt -C /home/config.yaml -R /home/config.ru start &
echo -n $! > /home/engines/run/control.pid 

startup_complete

wait 
exit_code=$?

shutdown_complete

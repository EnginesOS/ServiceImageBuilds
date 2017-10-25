#!/bin/sh

PID_FILE=/engines/var/run/control.pid
export PID_FILE
. /home/engines/functions/trap.sh


cd /home/app/
thin --threaded --ssl --ssl-key-file /engines/ssl/keys/engines.key --ssl-cert-file /engines/ssl/certs/engines.crt -C /home/config.yaml -R /home/config.ru start 1&2> /var/log/control_.log &

touch /engines/var/run/flags/startup_complete 
wait 
exit_code=$?
rm -f /engines/var/run/flags/startup_complete
sleep 600
exit $exit_code


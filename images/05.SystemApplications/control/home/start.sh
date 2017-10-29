#!/bin/sh

PID_FILE=/home/engines/run/control.pid
export PID_FILE
. /home/engines/functions/trap.sh
/home/deploy.sh
cd /home/app/
bundle exec thin --threaded --ssl --ssl-key-file /engines/ssl/keys/engines.key --ssl-cert-file /engines/ssl/certs/engines.crt -C /home/config.yaml -R /home/config.ru start &

touch /home/engines/run/flags/startup_complete 
wait 
exit_code=$?
rm -f /home/engines/run/flags/startup_complete

sleep 6000
exit $exit_code



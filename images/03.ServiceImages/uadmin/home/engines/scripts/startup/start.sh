#!/bin/sh

PID_FILE=/home/engines/run/uadmin.pid
export PID_FILE
. /home/engines/functions/trap.sh
export RACK_ENV production

/home/engines/scripts/engine/deploy.sh
  
thin -C /home/config.yaml -R /home/app/config.ru start > /var/log/system.log &
echo $! >$PID_FILE
    
startup_complete
wait 		
exit_code=$?		
sleep 500
shutdown_complete

#!/bin/sh

PID_FILE=/home/engines/run/clamav.pid
export PID_FILE
. /home/engines/functions/trap.sh
 
 sudo -n freshclam
sudo -n clamd &
echo $! > $PID_FILE


startup_complete

wait  
exit_code=$?
#debug
sleep 600

/home/engines/scripts/signal/_signal.sh
shutdown_complete


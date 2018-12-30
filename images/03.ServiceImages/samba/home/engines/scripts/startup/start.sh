#!/bin/sh

PID_FILE=/home/engines/run/pids.pid
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/stop_samba.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

service_first_run_check

sleep 600 &
echo $! > $PID_FILE

startup_complete
sudo -n /home/engines/scripts/engine/rebuild_config_file.sh
sudo -n /usr/sbin/smbd -F &
echo -n $! > $PID_FILE
sudo -n /usr/sbin/nmbd -F &
echo " $!" > $PID_FILE

wait
exit_code=$?

shutdown_complete

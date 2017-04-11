#!/bin/sh


PID_FILE=/home/cron/fcron.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/


sudo -n /home/engines/scripts/_start_syslog.sh


touch /engines/var/run/flags/startup_complete  
wait 
sleep 5000
sudo -n  /home/engines/scripts/_kill_syslog.sh
rm -f /engines/var/run/flags/startup_complete

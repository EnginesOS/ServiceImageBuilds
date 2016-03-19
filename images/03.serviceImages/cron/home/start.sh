#!/bin/sh


PID_FILE=/home/cron/fcron.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/


sudo -n syslogd  -R syslog.engines.internal:514
/home/cron/sbin/fcron -f -p  /home/cron/log/cron.log &
touch /engines/var/run/flags/startup_complete  
wait 
sudo -n  /home/engines/scripts/_kill_syslog.sh
rm -f /engines/var/run/flags/startup_complete

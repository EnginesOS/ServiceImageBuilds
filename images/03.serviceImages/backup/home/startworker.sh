#!/bin/sh

PID_FILE=/home/cron/fcron.pid
export PID_FILE
source /home/trap.sh


sudo -n  syslogd -n -R syslog.engines.internal:514
touch /var/run/startup_complete

/home/backup/fcron/sbin/fcron -f &

wait $!


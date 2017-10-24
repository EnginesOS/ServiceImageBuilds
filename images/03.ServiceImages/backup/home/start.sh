#!/bin/sh

rm -f /engines/var/run/flags/*

PID_FILE=/home/cron/fcron.pid
export PID_FILE
. /home/engines/functions/trap.sh

sudo -n /home/engines/scripts/_start_syslog.sh

mkdir -p /home/backup/sql_dumps/

/home/backup/fcron/sbin/fcron -f &
/home/backup/fcron/bin/fcrontab -u backup  -z 
touch /engines/var/run/flags/startup_complete
rm `find  /home/backup/.cache/duplicity/ -name lockfile.lock`
wait 
exit_code=$?

rm -f /engines/var/run/flags/startup_complete
sudo -n /home/engines/scripts/_kill_syslog.sh
exit $exit_code


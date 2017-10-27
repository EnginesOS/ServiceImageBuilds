#!/bin/sh

rm -f /home/engines/run/flags/*

PID_FILE=/home/cron/fcron.pid
export PID_FILE
. /home/engines/functions/trap.sh


mkdir -p /home/backup/sql_dumps/

/home/backup/fcron/sbin/fcron -f &
/home/backup/fcron/bin/fcrontab -u backup  -z 
touch /home/engines/run/flags/startup_complete
rm `find  /home/backup/.cache/duplicity/ -name lockfile.lock`
wait 
exit_code=$?

rm -f /home/engines/run/flags/startup_complete

exit $exit_code


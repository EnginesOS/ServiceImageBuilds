#!/bin/sh

rm -f /home/engines/run/flags/*

PID_FILE=/home/cron/fcron.pid
export PID_FILE
. /home/engines/functions/trap.sh


/home/backup/fcron/sbin/fcron -f &
/home/backup/fcron/bin/fcrontab -u backup  -z 
touch /home/engines/run/flags/startup_complete
if test -d home/backup/.cache/duplicity/
 then
	rm `find  /home/backup/.cache/duplicity/ -name lockfile.lock`
fi
wait 
exit_code=$?

rm /home/engines/run/flags/startup_complete

exit $exit_code


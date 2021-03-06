#!/bin/sh

PID_FILE=/home/engines/run/fcron.pid
export PID_FILE
. /home/engines/functions/trap.sh


/home/backup/fcron/sbin/fcron -f &

/home/backup/fcron/bin/fcrontab -u backup  -z 

startup_complete

if test -d home/backup/.cache/duplicity/
 then
	rm `find  /home/backup/.cache/duplicity/ -name lockfile.lock`
fi
wait 
exit_code=$?

shutdown_complete 


#!/bin/sh

mkdir -p /engines/var/run/flags


if ! test -f /engines/var/run/flags/first_run_done 
	 then
        bash /home/firstrun.sh         
fi


PID_FILE=/var/run/postgresql/9.3-main.pid
export PID_FILE
. /home/trap.sh

/usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf &

touch  /engines/var/run/flags/startup_complete

wait  

rm /engines/var/run/flags/startup_complete

#!/bin/sh

mkdir -p /engines/var/run/flags


if ! test -f /engines/var/run/flags/first_run_done 
	 then
        bash /home/firstrun.sh         
fi

 if ! test -f /home/postgres/.pgpass
  then
 cp /var/lib/postgresql/.pass /home/postgres/.pgpass
 chmod 600 /home/postgres/.pgpass 
fi

PID_FILE=/var/run/postgresql/9.5-main.pid
export PID_FILE
. /home/trap.sh

/usr/lib/postgresql/9.5/bin/postgres -D /var/lib/postgresql/9.5/main -c config_file=/etc/postgresql/9.5/main/postgresql.conf &
echo $! > /var/run/postgresql/9.5-main.pid
touch /engines/var/run/flags/startup_complete

wait  

rm /engines/var/run/flags/startup_complete

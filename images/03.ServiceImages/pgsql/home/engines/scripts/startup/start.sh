#!/bin/sh



PID_FILE=/home/engines/run/main.pid
export PID_FILE
. /home/engines/functions/trap.sh

service_first_run_check

if ! test -f /home/postgres/.pgpass
 then
   cp /var/lib/postgresql/.pass /home/postgres/.pgpass
   chmod 600 /home/postgres/.pgpass 
fi



/usr/lib/postgresql/9.5/bin/postgres -D /var/lib/postgresql/9.5/main -c config_file=/etc/postgresql/9.5/main/postgresql.conf &
echo $! > $PID_FILE

startup_complete

wait  
exit_code=$?

shutdown_complete


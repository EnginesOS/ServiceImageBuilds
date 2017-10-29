#!/bin/sh

#mkdir -p /home/engines/run/flags
#
#
#if ! test -f /home/engines/run/flags/first_run_done 
# then
#    /home/engines/scripts/first_run/first_run.sh         
#fi

PID_FILE=/var/run/postgresql/9.5-main.pid
export PID_FILE
. /home/engines/functions/trap.sh

service_first_run_check

if ! test -f /home/postgres/.pgpass
 then
   cp /var/lib/postgresql/.pass /home/postgres/.pgpass
   chmod 600 /home/postgres/.pgpass 
fi



/usr/lib/postgresql/9.5/bin/postgres -D /var/lib/postgresql/9.5/main -c config_file=/etc/postgresql/9.5/main/postgresql.conf &
echo $! > /var/run/postgresql/9.5-main.pid
touch /home/engines/run/flags/startup_complete

wait  
exit_code=$?

rm /home/engines/run/flags/startup_complete
exit $exit_code

#!/bin/sh


PID_FILE=/var/run/mysqld/mysqld.pid

export PID_FILE
. /home/engines/functions/trap.sh

if ! test -f /engines/var/run/flags/first_run_done 
then
 	echo running first run
    /home/engines/scripts/first_run/first_run.sh         
fi
 

SIGNAL=0

if test -f  /var/run/mysqld/mysqld.sock.lock 
 then
   echo "Remove stale sock lock"
   rm  /var/run/mysqld/mysqld.sock.lock
elif ! test -d /var/run/mysqld/
 then
   mkdir -p /var/run/mysqld/
fi 	

/usr/sbin/mysqld --defaults-file=/etc/mysql/my.cnf --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mysql/plugin --user=mysql --log-error=/var/log/mysql/error.log --pid-file=/var/run/mysqld/mysqld.pid --socket=/var/run/mysqld/mysqld.sock --bind-address=0.0.0.0 --port=3306 &
touch  /engines/var/run/flags/startup_complete
sleep 1
wait 
exit_code=$?
cat /var/log/mysql/error.log
 
rm /engines/var/run/flags/startup_complete
sleep 500
exit $exit_code
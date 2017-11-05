#!/bin/sh


PID_FILE=/var/run/mysqld/mysqld.pid

export PID_FILE
. /home/engines/functions/trap.sh

service_first_run_check

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

startup_complete

wait 
exit_code=$?
cat /var/log/mysql/error.log
 
shutdown_complete


#!/bin/sh

mkdir -p /engines/var/run/flags

 if ! test -f /engines/var/run/flags/first_run_done 
	 then
        bash /home/firstrun.sh         
fi


PID_FILE=/var/run/mysqld/mysqld.pid

export PID_FILE
. /home/trap.sh

SIGNAL=0
 	

 /usr/sbin/mysqld --defaults-file=/etc/mysql/my.cnf --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mysql/plugin --user=mysql --log-error=/var/log/mysql/error.log --pid-file=/var/run/mysqld/mysqld.pid --socket=/var/run/mysqld/mysqld.sock --port=3306 &
touch  /engines/var/run/flags/startup_complete


 while test $SIGNAL -ne 3 -a $SIGNAL -ne 15
 do
  if test -f $PID_FILE
  	then	
  	sleep 600 &
		wait 	
  fi
 done
 rm /engines/var/run/flags/startup_complete
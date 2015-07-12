#!/bin/sh

mkdir -p /engines/var/run/flags

PID_FILE=/var/run/mysqld/mysqld.pid
#source /home/trap.sh

if test -f $PID_FILE
 	then
 		echo "Warning stale $PID_FILE"
 		rm $PID_FILE
 	fi
 	


trap_term()
{
	if test -f $PID_FILE
	then
		kill -TERM `cat   $PID_FILE `
		touch /engines/var/run/flags/termed
	fi
}
trap_hup()
{
if test -f $PID_FILE
	then
		kill -HUP `cat   $PID_FILE `
		touch /engines/var/run/flags/huped
	fi
}
trap_quit()
{
if test -f $PID_FILE
	then
		kill -QUIT `cat   $PID_FILE `
		touch /engines/var/run/flags/quited
	fi
}

trap trap_term  15
trap trap_hup 1
trap trap_quit 3



/usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mysql/plugin --user=mysql --log-error=/var/log/mysql/error.log --pid-file=/var/run/mysqld/mysqld.pid --socket=/var/run/mysqld/mysqld.sock --port=3306
touch  /engines/var/run/startup_complete


sleep 30
while test -f /var/run/mysqld/mysqld.pid
do
	  sleep 20
done


rm /engines/var/run/startup_complete
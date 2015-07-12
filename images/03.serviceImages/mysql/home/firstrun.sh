#!/bin/bash
pass="pass"




 if ! test -f /var/lib/mysql/mysql
 then
 	cd /home/mysql
	/usr/bin/mysql_install_db
	 /usr/sbin/mysqld --defaults-file=/etc/mysql/my.cnf --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mysql/plugin --user=mysql --log-error=/var/log/mysql/error.log --pid-file=/var/run/mysqld/mysqld.pid --socket=/var/run/mysqld/mysqld.sock &
 pid=$!
 
 sleep 20
 
 while ! test -n /var/run/mysqld/mysqld.sock 	
 	do
 		sleep 10
 	done
	
	echo "CREATE USER 'rma'@'localhost';  grant all ON *.* TO  'rma'@'localhost'  WITH GRANT OPTION; " |mysql -u root
	echo "CREATE USER 'root'@'%' identified by '$pass';  grant all ON *.* TO  'root'@'%'  WITH GRANT OPTION; "
	echo "CREATE USER 'root'@'%' identified by '$pass';  grant all ON *.* TO  'root'@'%'  WITH GRANT OPTION; " |mysql -u root
	 /usr/bin/mysqladmin -u root  password '$pass'
	 
	 
	 kill -TERM $pid
	 wait $pid
	 touch /engines/var/run/flags/first_run_done
 fi
	 

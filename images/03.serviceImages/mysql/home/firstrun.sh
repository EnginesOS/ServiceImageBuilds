#!/bin/bash
pass=`dd if=/dev/urandom count=6 bs=1  | od -h | awk '{ print $2$3$4}'`




 if ! test -d /var/lib/mysql/mysql
 then
 	cd /home/mysql
 	mkdir -p /var/log/mysql
	#/usr/bin/mysql_install_db
	 mysqld --initialize   --explicit_defaults_for_timestamp 
	 
	
	 /usr/sbin/mysqld --skip-grant-tables --defaults-file=/etc/mysql/my.cnf --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mysql/plugin --user=mysql --log-error=/var/log/mysql/error.log --pid-file=/var/run/mysqld/mysqld.pid --socket=/var/run/mysqld/mysqld.sock &
 pid=$!
 
 sleep 20
 
 while ! test -n /var/run/mysqld/mysqld.sock 	
 	do
 		sleep 10
 	done
	
	echo "CREATE USER 'rma'@'localhost';  grant all ON *.* TO  'rma'@'localhost'  WITH GRANT OPTION; " |mysql  -S /var/run/mysqld/mysqld.sock  --protocol=socket -u root
	echo "CREATE USER 'root'@'localhost' identified by '$pass';  grant all ON *.* TO  'root'@'localhost'  WITH GRANT OPTION; "|mysql  -S /var/run/mysqld/mysqld.sock  --protocol=socket  -u root
	
	echo "CREATE USER 'root'@'%' identified by '$pass';  grant all ON *.* TO  'root'@'%'  WITH GRANT OPTION; " |mysql  -S /var/run/mysqld/mysqld.sock  --protocol=socket -u root
	 /usr/bin/mysqladmin  -S /var/run/mysqld/mysqld.sock  --protocol=socket -u root  password $pass
	 
	 echo -n $pass > /var/lib/mysql/.pass
	 kill -TERM $pid
	 wait $pid
	 touch /engines/var/run/flags/first_run_done
 fi
	 

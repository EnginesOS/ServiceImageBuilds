#!/bin/sh

if ! test -d  /var/run/mysqld/
 then
 	echo "setup run dir"
 	mkdir -p /var/run/mysqld/
 	chown mysql /var/run/mysqld/
fi

if ! test -d  /var/log/mysql/
 then
 	echo "setup log dir"
 	mkdir -p /var/log/mysql
 	chown mysql /var/log/mysql/ 	
fi
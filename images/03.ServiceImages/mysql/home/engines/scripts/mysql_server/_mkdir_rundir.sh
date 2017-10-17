#!/bin/bash

if ! test -d  /var/run/mysqld/
 then
 	echo "setup run dir"
 	mkdir -p /var/run/mysqld/
 	chown mysql /var/run/mysqld/
fi

if ! test -d  /var/log/mysqld/
 then
 	echo "setup run dir"
 	mkdir -p /var/log/mysqld/
 	chown mysql /var/log/mysqld/ 	
fi